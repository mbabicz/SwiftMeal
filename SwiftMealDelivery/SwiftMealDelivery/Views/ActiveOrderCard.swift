//
//  ActiveOrderCard.swift
//  SwiftMealDelivery
//
//  Created by mbabicz on 30/07/2023.
//

import SwiftUI

struct ActiveOrderCard: View {
    
    var order: Order
    @EnvironmentObject var orderVM: OrderViewModel

    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .fill(.white)
                .shadow(radius: 10)
            HStack{
                VStack{
                    Text(order.id)
                        .padding()
                }
                Spacer()
                Button {
                    orderVM.updateOrder(orderID: order.id, userID: order.orderedBy!, isActive: true)
                } label: {
                    Text("Accept")
                }
                .padding()
            }
        }
        .padding()
    }
}

struct ActiveOrderCard_Previews: PreviewProvider {
    static var previews: some View {
        ActiveOrderCard(order: Order.sampleOrder)
    }
}
