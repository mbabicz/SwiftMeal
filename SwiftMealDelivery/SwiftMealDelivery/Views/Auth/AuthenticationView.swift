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
