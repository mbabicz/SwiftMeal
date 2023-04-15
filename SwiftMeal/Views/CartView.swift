//
//  CartView.swift
//  SwiftMeal
//
//  Created by kz on 15/04/2023.
//

import SwiftUI

struct CartView: View {
    
    @StateObject private var imageLoader = ImageLoader()
    @EnvironmentObject var mealViewModel: MealViewModel
    
    var body: some View {
        if mealViewModel.meals != nil {
            ForEach(mealViewModel.cartMeals.sorted(by: { $0.key.name < $1.key.name }), id: \.key) { meal, quantity in
                Text("\(meal.name) - \(quantity)")
            }
        } else {
            Text("no meals in cart")
        }
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView()
    }
}