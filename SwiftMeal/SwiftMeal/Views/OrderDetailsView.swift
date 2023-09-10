//
//  OrderDetailsView.swift
//  SwiftMeal
//
//  Created by mbabicz on 12/07/2023.
//

import SwiftUI
import Foundation

struct OrderDetailsView: View {
    
    var order: Order

    var body: some View {
        Text(order.id)
        Text("\(order.date)")
        Text(order.formattedDate)
        Text(order.formattedTotalPrice)
        Text(order.status.name)
        Text(String(order.isActive))
        
        MapView(currentLongitude: order.longitude!, currentLatitude: order.latitude!)
//        if order.status != .ordered { .
//            //            MapView(currentLongtitude: order.longitude!, currentLatitude: order.latitude!)
//         MapView()
//        }
    }
}

struct OrderDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        OrderDetailsView(order: Order.sampleOrder)
    }
}
