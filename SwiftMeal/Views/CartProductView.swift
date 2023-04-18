//
//  CartProductView.swift
//  SwiftMeal
//
//  Created by kz on 17/04/2023.
//

import SwiftUI

struct CartProductView: View {
    
    var meal: Meal
    @State var quantity: Int
    @StateObject private var imageLoader = ImageLoader()
    @EnvironmentObject var mealViewModel: MealViewModel

    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .fill(.white)
                .shadow(radius: 10)
                .frame(height: 140)
                .padding(10)
            VStack{
                HStack{
                    if let image = imageLoader.image {
                        Image(uiImage: image)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 75)
                            .cornerRadius(20)
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .leading){
                        Text(meal.name)
                            .font(.title2)
                            .bold()
                            .lineLimit(1)
                            .fixedSize()
                        HStack{
                            VStack(alignment: .leading){
                                Text("category: \(meal.category)")
                                    .font(.footnote)
                                
                                Text("price: \(meal.formattedPrice)")
                                    .font(.footnote)
                                    .fixedSize()
                            }
                            
                            Spacer()
                            
                            HStack{
                                CustomStepper(stepperValue: $quantity)
                                    .font(.caption2)
                                
                                Text("\(quantity)")
                                    .fixedSize()
                            }
                        }
                    }
                    Spacer()
                }
                
                HStack{
                    Spacer()
                    Text(String(format: "%.2f$", meal.price * Double(quantity)))
                        .font(.title3)
                        .foregroundColor(.black)
                        .bold()
                }
            }
            .padding(.horizontal, 20)
            VStack(alignment: .trailing){
                HStack{
                    Spacer()
                    Button {
                        mealViewModel.removeMealFromCart(meal)
                    } label: {
                        Image(systemName: "trash.fill")
                    }
                    .padding(.top, 15)
                    .padding(.trailing, 25)
                    
                }
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: 150)
        }
        .onAppear {
            imageLoader.loadImage(with: meal.imageURL)
        }
        
        .onChange(of: quantity) { newQuantity in
            mealViewModel.cartMeals[meal] = newQuantity
            mealViewModel.calculateTotalPrice()
            if newQuantity == 0 {
                mealViewModel.removeMealFromCart(meal)
            }
        }

    }
}
