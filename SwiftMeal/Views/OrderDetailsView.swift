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
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct OrderDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        OrderDetailsView(order: Order.sampleOrder)
    }
}
