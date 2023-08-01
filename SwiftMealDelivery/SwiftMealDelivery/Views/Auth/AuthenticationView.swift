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
                    Button {
                        vm.activeSheet = .signIn
                    } label: {
                        Text("Sign In")
                            .padding()
                            .foregroundColor(.black)
                            .background(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 1))
                    }
                    .padding()

                    Button {
                        vm.activeSheet = .signUp
                    } label: {
                        Text("Sign Up")
                            .padding()
                            .foregroundColor(.black)
                            .background(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 1))
                    }
                    .padding()
                }
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

