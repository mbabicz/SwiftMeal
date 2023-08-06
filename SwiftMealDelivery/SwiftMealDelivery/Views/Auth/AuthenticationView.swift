//
//  AuthenticationView.swift
//  SwiftMealDelivery
//
//  Created by mbabicz on 01/08/2023.
//

import SwiftUI

struct AuthenticationView: View {
    @EnvironmentObject var vm: AuthViewModel

    var body: some View {
        VStack {
            if vm.activeSheet == nil {
                VStack {
                    
                    Spacer()
                    
                    LogoView()

                    Spacer()
                    
                    Button(action: {
                        withAnimation{
                            vm.activeSheet = .signIn
                        }
                    }) {
                        Text("Log in")
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.orange)
                            .cornerRadius(12)
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color.black, lineWidth: 1)
                                )
                    }
                    .padding(.bottom, 10)
                    
                    Button(action: {
                        withAnimation{
                            vm.activeSheet = .signUp
                        }
                    }) {
                        Text("New account")
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.black)
                            .cornerRadius(12)
                    }
                    Spacer()
                }
                .padding()
                .padding(.horizontal)
                
                Spacer()
                
            } else {
                if vm.activeSheet == .signIn {
                    SignInView()
                        .transition(.move(edge: .trailing))
                } else if vm.activeSheet == .signUp {
                    SignUpView()
                        .transition(.move(edge: .trailing))
                }
            }
        }
    }
}
