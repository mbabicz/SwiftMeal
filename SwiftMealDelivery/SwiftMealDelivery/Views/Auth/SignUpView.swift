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
            
            HStack {
                Image("burger")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 65, height: 65)
                VStack(alignment: .leading) {
                    Text("SwiftMeal")
                        .font(.custom("HelveticaNeue-Bold", size: 45))
                        .fontWeight(.bold)
                        .foregroundColor(.orange)
                    Text("Delivery")
                        .font(.custom("HelveticaNeue-Bold", size: 20))
                        .foregroundColor(.gray)
                }
            }
            
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

struct AuthButton: View {
    let imageName: String
    let text: String
    let backgroundColor: Color
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20)
                Text(text)
                    .foregroundColor(.black)
                
                Spacer()
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(backgroundColor)
            .cornerRadius(12)
            .foregroundColor(.white)
            .overlay(RoundedRectangle(cornerRadius: 12).stroke(.black, lineWidth: 0.5))
        }
    }
}

struct TogglePasswordView: View {
    @Binding var isSecured: Bool
    let placeholder: String
    @Binding var text: String
    
    var body: some View {
        ZStack(alignment: .trailing) {
            if isSecured {
                SecureField(placeholder, text: $text)
            } else {
                TextField(placeholder, text: $text)
            }
            Button(action: {
                isSecured.toggle()
            }) {
                Image(systemName: isSecured ? "eye.slash" : "eye")
                    .accentColor(.gray)
            }
        }
        .padding()
        .background(Color.gray.opacity(0.2))
        .cornerRadius(12)
    }
}

struct AuthTextField: View {
    let placeholder: String
    @Binding var text: String
    
    var body: some View {
        TextField(placeholder, text: $text)
            .padding()
            .background(Color.gray.opacity(0.2))
            .cornerRadius(12)
    }
}

