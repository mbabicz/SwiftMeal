//
//  SignUpView.swift
//  SwiftMealDelivery
//
//  Created by mbabicz on 01/08/2023.
//

import SwiftUI

struct SignUpView: View {
    
    @EnvironmentObject var vm: AuthViewModel

    var body: some View {
        Button {
            vm.activeSheet = .signIn
        } label: {
            Text("signIn")
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
