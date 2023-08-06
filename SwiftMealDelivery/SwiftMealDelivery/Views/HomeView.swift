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

    var body: some View {
        VStack{
            if !orderVM.activeOrders.isEmpty{
                Text("Active orders")
                    .font(.title)
                ScrollView {
                    ForEach(orderVM.activeOrders) { order in
                        ActiveOrderCard(order: order)
                    }
                }
            }
        }
    }
}
