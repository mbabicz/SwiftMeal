//
//  OrderDetailsView.swift
//  SwiftMeal
//
//  Created by mbabicz on 12/07/2023.
//

import SwiftUI

struct OrderDetailsView: View {
    
    var order: Order

    var body: some View {
        Text(order.id)
        Text("\(order.date)")
        Text(order.formattedDate)
        Text(order.formattedTotalPrice)
        Text(order.status.name)
        Text(String(order.isActive)) 


    }
}

struct OrderDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        OrderDetailsView(order: Order.sampleOrder)
    }
}
