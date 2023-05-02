//
//  OrderHistoryView.swift
//  SwiftMeal
//
//  Created by kz on 30/04/2023.
//

import SwiftUI

struct OrderHistoryView: View {
    
    @EnvironmentObject var orderViewModel: OrderViewModel
    
    var body: some View {
        
        let activeOrders = orderViewModel.orders.filter { $0.isActive }
        let inactiveOrders = orderViewModel.orders.filter { !$0.isActive }
        let sortedOrders = activeOrders + inactiveOrders.sorted(by: { $0.date > $1.date })
        
        ForEach(sortedOrders) { order in
            VStack{
                HStack{
                    Text(order.formattedDate)
                    Spacer()
                    Text(order.status)
                }
                .padding(.horizontal)
                
                HStack(alignment: .bottom){
                    VStack{
                        
                        ForEach(order.products.sorted(by: <), id: \.key) { (product, amount) in
                            Text("\(product) \(amount)")
                        }
                    }
                    Text(order.formattedTotalPrice)
                }
            }
            .padding()
        }

    }
}

struct OrderHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        OrderHistoryView()
    }
}
