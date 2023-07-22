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
            ZStack{
                ScrollView(){
                    ForEach(mealViewModel.cartMeals.sorted(by: { $0.key.name < $1.key.name }), id: \.key) { meal, quantity in
                        CartProductView(meal: meal, quantity: quantity)
                    }
                    Spacer()
                }
                .padding(.bottom, 60)
                VStack(spacing: 0){
                    Spacer()
                    NavigationLink(destination: PaymentView()) {
                        HStack() {
                            Image(systemName: "cart.fill")
                                .bold().font(.callout)
                            Text("Go to payment: \(String(format: "%.2f", mealViewModel.totalCartPrice))$")
                                .bold().font(.callout)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(15)
                        .foregroundColor(.white)
                        .background(Color.green)
                        .cornerRadius(10)
                        .shadow(radius: 10)
                    }
                    .padding(.horizontal)
                }
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
