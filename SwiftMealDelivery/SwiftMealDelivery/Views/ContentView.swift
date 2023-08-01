//
//  ContentView.swift
//  SwiftMealDelivery
//
//  Created by mbabicz on 14/07/2023.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var orderViewModel: OrderViewModel
    
    var body: some View {
        AuthenticationView()
//        HomeView()
//            .onAppear{
//                orderViewModel.fetchActiveOrders()
//            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
