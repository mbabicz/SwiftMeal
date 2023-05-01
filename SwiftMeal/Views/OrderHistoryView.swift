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
        ForEach(orderViewModel.orders) { order in
            Text(order.formattedDate)
        }
        
    }
}

struct OrderHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        OrderHistoryView()
    }
}
