//
//  HomeView.swift
//  SwiftMealDelivery
//
//  Created by mbabicz on 22/07/2023.
//

import Foundation
import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var orderViewModel: OrderViewModel

    var body: some View {
        
        if !orderViewModel.activeOrders.isEmpty{
            Text("Active orders")
                .font(.title)
            ScrollView {
                ForEach(orderViewModel.activeOrders) { order in
                    ActiveOrderCard(order: order)
                }
            }
        }
    }
}
