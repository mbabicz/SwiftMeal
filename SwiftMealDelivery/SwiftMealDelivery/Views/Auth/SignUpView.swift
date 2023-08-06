//
//  SignUpView.swift
//  SwiftMealDelivery
//
//  Created by mbabicz on 01/08/2023.
//

import SwiftUI

struct SignUpView: View {
    
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
                    Text("Create a new account!")
                        .font(.custom("HelveticaNeue", size: 18))
                        .foregroundColor(.gray)
                    
                    AuthButton(imageName: "google_logo", text: "Continue with Google", backgroundColor: .gray.opacity(0.2), action: {
                        // Handle Google auth
                    })
                    
                    AuthButton(imageName: "envelope", text: "Continue with Email", backgroundColor: .orange, action: {
                        withAnimation {
                            showEmailForm.toggle()
                        }
                    })
                    
                    Spacer()
                    
                    Button(action: {
                        vm.activeSheet = .signIn
                    }) {
                        Text("Have an account? Log In")
                            .foregroundColor(.black)
                    }
                }
            }
            
            if showEmailForm {
                VStack(spacing: 20) {
                    AuthTextField(placeholder: "Email", text: $email)
                    TogglePasswordView(isSecured: $isSecured, placeholder: "Password", text: $password)
                    TogglePasswordView(isSecured: $isSecuredConfirmation, placeholder: "Confirm password", text: $passwordConfirmation)
                    
                    AuthButton(imageName: "envelope", text: "Sign Up", backgroundColor: .orange, action: {
                        if !email.isEmpty && !password.isEmpty {
                            vm.signUp(email: email, password: password)
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
