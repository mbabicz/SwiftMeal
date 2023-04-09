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
            VStack{
                if imageLoader.image != nil {
                    Image(uiImage: imageLoader.image!)
                        .resizable()
                        .compositingGroup()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100)
                        .cornerRadius(12)
                }
                Text(meal.name)
                    .font(.headline)
                    .bold()
                    .padding(.bottom, 10)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 100)

            .padding()
            .onAppear {
                imageLoader.loadImage(with: meal.imageURL)
            }
            .background(Color(red: 240/255, green: 247/255, blue: 255/255))
        }
        .cornerRadius(20)
    }
}
