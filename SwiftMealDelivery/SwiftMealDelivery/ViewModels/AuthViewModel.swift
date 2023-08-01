//
//  UserViewModel.swift
//  SwiftMealDelivery
//
//  Created by mbabicz on 01/08/2023.
//

import Foundation

class AuthViewModel: ObservableObject {
    
    @Published var activeSheet: ActiveSheet? = nil
    
    enum ActiveSheet {
        case signIn, signUp
    }

}
