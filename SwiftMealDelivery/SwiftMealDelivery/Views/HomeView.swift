//
//  HomeView.swift
//  SwiftMealDelivery
//
//  Created by mbabicz on 22/07/2023.
//

import Foundation
import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var orderVM: OrderViewModel
    @EnvironmentObject var authVM: AuthViewModel

    var body: some View {
        ScrollView {
            Text("Active orders")
                .font(.title)
            if !orderVM.activeOrders.isEmpty{
                ForEach(orderVM.activeOrders) { order in
                    ActiveOrderCard(order: order)
                }
            }
            Text("My orders")
                .font(.title)
            if !orderVM.userOrders.isEmpty {
                ForEach(orderVM.userOrders) { order in
                    ActiveOrderCard(order: order)
                }
            }
            Spacer()
            Button {
                authVM.signOut()
            } label: {
                Text("sign out")
            }
            
        }
        .onAppear{
            orderVM.fetchUserOrders()
        }
    }
}
