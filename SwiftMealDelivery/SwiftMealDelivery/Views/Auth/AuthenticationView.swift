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
                    .padding(.vertical)

                    Spacer()
                    
                    Button(action: {
                        vm.activeSheet = .signIn
                    }) {
                        Text("Sign In")
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.black)
                            .cornerRadius(10)
                    }
                    
                    Button(action: {
                        vm.activeSheet = .signUp
                    }) {
                        Text("Sign Up")
                            .foregroundColor(.black)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.black, lineWidth: 1)
                            )
                    }
                    Spacer()
                }
                .padding()
                
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
