//
//  ContentView.swift
//  SwiftMealDelivery
//
//  Created by mbabicz on 14/07/2023.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var authVM: AuthViewModel
    @EnvironmentObject var orderVM: OrderViewModel

    
    var body: some View {
        NavigationView {
            if !authVM.userIsAuthenticated {
                AuthenticationView()
            } else if !authVM.userIsAuthenticatedAndSynced {
                LoadingView()
            } else {
                HomeView()
            }
        }
        .onAppear{
            if authVM.userIsAuthenticated{
                authVM.syncUser()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
