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
        HStack{
            if imageLoader.image != nil {
                HStack {
                    Spacer()
                    Image(uiImage: imageLoader.image!)
                        .resizable()
                        .compositingGroup()
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(12)

                    Spacer()
                }
            }
            VStack{
                Text(meal.strMeal)
                Text(meal.strCategory)

            }

        }
        .onAppear {
            imageLoader.loadImage(with: meal.strMealThumb)
        }
    }
}

//struct MealCard_Previews: PreviewProvider {
//    static var previews: some View {
//        MealCard()
//    }
//}
