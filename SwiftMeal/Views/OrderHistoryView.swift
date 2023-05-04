//
//  OrderHistoryView.swift
//  SwiftMeal
//
//  Created by kz on 30/04/2023.
//

import SwiftUI

struct OrderHistoryView: View {
    
    @EnvironmentObject var orderViewModel: OrderViewModel
    @EnvironmentObject var mealViewModel: MealViewModel

    
    var body: some View {
        
        let activeOrders = orderViewModel.orders.filter { $0.isActive }
        let inactiveOrders = orderViewModel.orders.filter { !$0.isActive }
        let sortedOrders = activeOrders + inactiveOrders.sorted(by: { $0.date > $1.date })
        
        ScrollView{
            ForEach(sortedOrders) { order in
                ZStack{
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .fill(.white)
                        .shadow(radius: 10)
                    VStack{
                        HStack{
                            Text(order.formattedDate).foregroundColor(.gray)
                            Spacer()
                            Text(order.status).foregroundColor(order.isActive ? .green : .black)
                        }
                        .padding(.vertical)
                        
                        VStack(alignment: .leading){
                            
                            ForEach(order.products.sorted(by: <), id: \.key) { (productID, amount) in
                                if let meal = mealViewModel.meals?.first(where: { $0.id == productID }) {
                                    Text("\(amount)x \(meal.name)")
                                }
                            }
                            
                            HStack{
                                Spacer()
                                Text(order.formattedTotalPrice)
                                    .bold()
                            }
                        }
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 15)
                }
                .padding(5)
                .padding(.horizontal, 5)
            }
        }
    }
}

struct OrderHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        OrderHistoryView()
    }
}
