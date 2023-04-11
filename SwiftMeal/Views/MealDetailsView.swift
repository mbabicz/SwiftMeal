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
            Rectangle()
                .fill(Color.white)
                .frame(maxWidth: .infinity)
                .frame(height: 250)
                .overlay(
                    VStack{
                        Text("Meal category: \(meal.category)")
                            .font(.footnote)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding([.horizontal, .top])
//
                        Text("Ingredients: \(meal.ingredients.joined(separator: ", "))")
                            .font(.footnote)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding([.horizontal, .bottom])
                        
                        Text(meal.description)
                            .font(.body)
                            .padding([.horizontal ,.bottom])

                        HStack(alignment: .center){
                            Text(meal.formattedPrice)
                                .font(.headline)
                                .padding(.trailing, 20)
                            
                            Button {

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
                            .padding(.leading, 20)

                            //.padding(20)
                        }
                        Spacer()
                        
                    }
                )
                .cornerRadius(12)
                .shadow(color: .gray, radius: 4, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/)
                .padding(5)
            
            
            Spacer()
        }
        .padding([.leading, .trailing], 10)
        .onAppear {
            imageLoader.loadImage(with: meal.imageURL)
        }
    }
}
