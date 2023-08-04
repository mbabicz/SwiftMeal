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
    @State private var showOptions = true
    @State private var email = ""
    @State private var password = ""
    @State private var passwordConfirmation = ""
    
    var body: some View {
        VStack(spacing: 20) {
            
            Spacer()
            
            HStack{
                Image("burger")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 65, height: 65)
                VStack(){
                    Text("SwiftMeal")
                        .font(.custom("HelveticaNeue-Bold", size: 45))
                        .fontWeight(.bold)
                        .foregroundColor(.orange)
                    Text("Delivery")
                        .frame(alignment: .trailing)
                        .font(.custom("HelveticaNeue-Bold", size: 20))
                }
            }
            
            Spacer(minLength: 20)
            
            if showOptions {
                Text("Create a new account!")
                    .frame(alignment: .trailing)
                    .font(.custom("HelveticaNeue", size: 18))
                    .foregroundColor(.gray)
                
                Button(action: {
                    // google auth
                }) {
                    HStack {
                        Image("google_logo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20)
                        Text("Continue with Google")
                        
                        Spacer()
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(12)
                    .foregroundColor(.black)
                    .overlay(RoundedRectangle(cornerRadius: 12).stroke(.black, lineWidth: 0.5))
                    
                }
                
                Button(action: {
                    withAnimation {
                        self.showEmailForm.toggle()
                        self.showOptions.toggle()
                    }
                }) {
                    HStack {
                        Image(systemName: "envelope.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20)
                        Text("Continue with Email")
                        
                        Spacer()
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.orange)
                    .cornerRadius(12)
                    .foregroundColor(.white)
                    .overlay(RoundedRectangle(cornerRadius: 12).stroke(.black, lineWidth: 0.5))
                    
                }
                
                Spacer()
                
                Button {
                    vm.activeSheet = .signIn
                } label: {
                    HStack {
                        Text("Have an account?")
                        Text("Log In")
                            .underline()
                    }
                    .foregroundColor(.black)
                }
                
            }
            
            if showEmailForm {
                VStack(spacing: 20) {
                    TextField("Email", text: $email)
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(12)
                    
                    SecureField("Password", text: $password)
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(12)
                    SecureField("Confirm password", text: $passwordConfirmation)
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(12)
                        .padding(.bottom)
                    
                    Button(action: {
                        if (!email.isEmpty && !password.isEmpty){
                            vm.signUp(email: email, password: password)
                        } else{
                            vm.alertTitle = "Error"
                            vm.alertMessage = "Pola nie mogą by puste"
                            vm.showingAlert = true
                        }
                    }) {
                            Text("Sign Up")
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.orange)
                                .cornerRadius(12)
                                .foregroundColor(.white)
                                .overlay(RoundedRectangle(cornerRadius: 12).stroke(.black, lineWidth: 0.5))
                        }
                    
                    Button(action: {
                        withAnimation {
                            self.showEmailForm.toggle()
                            self.showOptions.toggle()
                        }
                    }) {
                        Text("Back")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.gray.opacity(0.2))
                            .foregroundColor(.black)
                        
                            .cornerRadius(12)
                            .overlay(RoundedRectangle(cornerRadius: 12).stroke(.black, lineWidth: 0.5))
                    }
                }
                .transition(.slide)
            }
            Spacer()
        }
        .padding(.horizontal)
        .padding()
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}

