//
//  SignInView.swift
//  SwiftMealDelivery
//
//  Created by mbabicz on 01/08/2023.
//

import SwiftUI

struct SignInView: View {
    
    @EnvironmentObject var vm: AuthViewModel

    var body: some View {
        Button {
            vm.activeSheet = .signUp

        } label: {
            Text("signUp")
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
