//
//  SignInView.swift
//  SwiftMealDelivery
//
//  Created by mbabicz on 01/08/2023.
//

import SwiftUI

struct SignInView: View {
    
    @EnvironmentObject var vm: AuthViewModel
    
    @State private var showEmailForm = false
    @State private var email = ""
    @State private var password = ""
    @State private var passwordConfirmation = ""
    
    @State private var isSecured: Bool = true
    @State private var isSecuredConfirmation: Bool = true
    
    var body: some View {
        VStack(spacing: 20) {
            
            Spacer()
            
            LogoView()
            
            Spacer(minLength: 20)
            
            if !showEmailForm {
                VStack(spacing: 20) {
                    Text("Log in to your account!")
                        .font(.custom("HelveticaNeue", size: 18))
                        .foregroundColor(.gray)
                    
                    AuthButton(imageName: "google_logo", text: "Log in with Google", backgroundColor: .gray.opacity(0.2), action: {
                        // Handle Google auth
                    })
                    
                    AuthButton(imageName: "envelope", text: "Log in with Email", backgroundColor: .orange, action: {
                        withAnimation {
                            showEmailForm.toggle()
                        }
                    })
                    
                    Spacer()
                    
                    Button(action: {
                        vm.activeSheet = .signUp
                    }) {
                        Button {
                            vm.activeSheet = .signUp
                        } label: {
                            HStack {
                                Text("Don't have an account?")
                                Text("Create")
                                    .underline()
                            }
                            .foregroundColor(.black)
                        }
                    }
                }
            }
            
            if showEmailForm {
                VStack(spacing: 20) {
                    AuthTextField(placeholder: "Email", text: $email)
                    TogglePasswordView(isSecured: $isSecured, placeholder: "Password", text: $password)
                    
                    AuthButton(imageName: "envelope", text: "Sign In", backgroundColor: .orange, action: {
                        if !email.isEmpty && !password.isEmpty {
                            vm.signIn(email: email, password: password)
                        } else {
                            vm.updateAlert(title: "Error", message: "Fields cannot be empty")
                        }
                    })
                    
                    AuthButton(imageName: "back", text: "Back", backgroundColor: .gray.opacity(0.2), action: {
                        withAnimation {
                            showEmailForm.toggle()
                        }
                    })
                }
                .transition(.slide)
            }
            
            Spacer()
        }
        .padding(.horizontal)
        .padding()
    }
}
