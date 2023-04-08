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
    
    var body: some View {
        ZStack{
            HStack{
                if imageLoader.image != nil {
                    Image(uiImage: imageLoader.image!)
                        .resizable()
                        .compositingGroup()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100)
                        .cornerRadius(12)
                }
                Spacer()
                VStack{
                    Text(meal.name)
                        .font(.headline)
                        .bold()
                        .padding(.bottom, 10)
                    Text(meal.ingredients.compactMap { $0 != "" ? $0 : nil }.joined(separator: ", "))
                            .font(.caption2)
                            .foregroundColor(.gray)



                }
            }
            .padding()
            .onAppear {
                imageLoader.loadImage(with: meal.imageURL)
            }
//            .onChange(of: meal) { newMeal in
//                imageLoader.loadImage(with: newMeal.strMealThumb)
//            }

            .background(Color(red: 240/255, green: 247/255, blue: 255/255))
        }
        .cornerRadius(20)
        .padding([.leading, .trailing])
    }
}
