//
//  MealDetailsView.swift
//  SwiftMeal
//
//  Created by kz on 06/04/2023.
//

import SwiftUI

struct MealDetailsView: View {
    
    var meal: Meal
    @StateObject private var imageLoader = ImageLoader()
    
    var body: some View {
        ScrollView{
            Text(meal.name)
                .font(.title)
                .bold()
                .padding()
            if imageLoader.image != nil {
                Image(uiImage: imageLoader.image!)
                    .resizable()
                    .compositingGroup()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: 200)
                    .cornerRadius(12)
                    .padding()
                
            }
            ZStack{
                RoundedRectangle(cornerRadius: 25, style: .continuous)
                    .fill(.white)
                    .shadow(radius: 10)
                VStack{
                    Text(meal.description)
                        .font(.headline)
                        .padding(10)
                        .multilineTextAlignment(.center)
                        .fixedSize(horizontal: false, vertical: true)
                    
                    Text("Meal category: \(meal.category)")
                        .font(.footnote)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)

                    Text("Ingredients: \(meal.ingredients.joined(separator: ", "))")
                        .font(.footnote)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding([.horizontal, .bottom])
                    
                    
                    Text(verbatim: meal.nutrition.joined(separator: "\n\t• "))
                        .font(.footnote)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                    
                    HStack(alignment: .center){
                        Text(meal.formattedPrice)
                            .font(.headline)
                            .padding(.trailing, 20)
                        
                        Button {
                            
                        } label: {
                            HStack() {
                                Image(systemName: "cart.badge.plus")
                                    .bold().font(.callout)
                                Text("Add to cart")
                                    .bold().font(.callout)
                            }
                            .padding(8)
                            .foregroundColor(.white)
                            .background(Color.green)
                            .cornerRadius(45)
                        }
                        .padding(.leading, 20)
                    }
                    .padding(.top)

                    Spacer()
                }
            }
            Spacer()
        }
        .onAppear {
            imageLoader.loadImage(with: meal.imageURL)
        }
    }
}
