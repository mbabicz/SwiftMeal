//
//  MealCard.swift
//  SwiftMeal
//
//  Created by kz on 04/04/2023.
//

import SwiftUI

struct MealCard: View {
    
    var meal: Meal
    @StateObject private var imageLoader = ImageLoader()
    @EnvironmentObject var mealViewModel: MealViewModel
    @Binding var showAddedPrice: Bool
    @Binding var addedPrice: Double
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .fill(.white)
                .shadow(radius: 10)
            
            VStack{
                Text(meal.name)
                    .font(.headline)
                    .bold()
                    .padding(.top, 15)
                    .padding(.horizontal, 10)
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    .lineLimit(3)
                if imageLoader.image != nil {
                    Image(uiImage: imageLoader.image!)
                        .resizable()
                        .compositingGroup()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 75)
                        .cornerRadius(20)
                } else {
                    Image("burger")
                        .resizable()
                        .compositingGroup()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 75)
                        .cornerRadius(20)
                }

                Text(meal.formattedPrice)
                    .font(.subheadline)
                    .foregroundColor(.black)
                
                Button {
                    mealViewModel.addToCart(meal.id, 1)
                    withAnimation(){
                        showAddedPrice = true
                        addedPrice = meal.price
                    }
                } label: {
                    HStack() {
                        Image(systemName: "cart.badge.plus")
                            .bold().font(.caption)
                        Text("Add to cart")
                            .bold().font(.caption)
                    }
                    .padding(8)
                    .foregroundColor(.white)
                    .background(Color.green)
                    .cornerRadius(45)
                }
                .padding(.bottom, 20)
            }
            .onAppear {
                imageLoader.loadImage(with: meal.imageURL)
                addedPrice = meal.price
            }
        }
    }
}
