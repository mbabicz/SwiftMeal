//
//  PurchaseView.swift
//  SwiftMeal
//
//  Created by kz on 25/04/2023.
//

import SwiftUI

struct PaymentView: View {
    
    @EnvironmentObject var mealViewModel: MealViewModel
    @EnvironmentObject var orderViewModel: OrderViewModel


    var body: some View {
        NavigationView {
            
            VStack(alignment:.leading, spacing: 0){
                ScrollView(){
                    ForEach(mealViewModel.cartMeals.sorted(by: { $0.key.name < $1.key.name }), id: \.key) { meal, quantity in
                        PaymentProductCart(meal: meal, quantity: quantity)
                        Divider()
                    }
                    Spacer()
                }
                .padding(.bottom, 60)
                
                Spacer()
                Button {
                    let mealIDs = mealViewModel.cartMeals.keys.map { $0.id }
                    orderViewModel.submitOrder(mealIDs: mealIDs, totalPrice: mealViewModel.totalCartPrice) {
                        mealViewModel.deleteCurrentCart()
                    }
                } label: {
                    HStack() {
                        Image(systemName: "cart.fill")
                            .bold().font(.callout)
                        Text("Delivery details: \(String(format: "%.2f$", mealViewModel.totalCartPrice))")
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
        .navigationBarTitle("Confirmation")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct PaymentView_Previews: PreviewProvider {
    static var previews: some View {
        PaymentView()
    }
}
