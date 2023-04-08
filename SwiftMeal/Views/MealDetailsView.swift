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
        NavigationView{
            ScrollView{
                HStack(spacing: 0){
//                    Text(meal.strArea)
//                        .font(.footnote)
//                        .foregroundColor(.gray)
                    Spacer()
                    Text(meal.category)
                        .font(.footnote)
                        .foregroundColor(.gray)
                }
                .padding(.horizontal, 10)
                if imageLoader.image != nil {
                    Image(uiImage: imageLoader.image!)
                        .resizable()
                        .compositingGroup()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: .infinity)
                        .cornerRadius(12)
                }
//                ZStack{
//                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], alignment: .leading, spacing: 0) {
//                        ForEach(0..<meal.ingredients.count) { index in
//                            if let ingredient = meal.ingredients.indices.contains(index) ? meal.ingredients[index] : nil,
//                               let measure = meal.measures.indices.contains(index) ? meal.measures[index] : nil,
//                               !ingredient.isEmpty {
//                                VStack(alignment: .leading, spacing: 2) {
//                                    HStack(alignment: .center, spacing: 4) {
//                                        Image(systemName: "circle.fill")
//                                            .foregroundColor(.gray)
//                                            .font(.system(size: 6))
//                                        Text("\(ingredient) \(measure)")
//                                            .foregroundColor(.gray)
//                                            .multilineTextAlignment(.leading)
//                                            .font(.callout)
//                                    }
//                                }
//                            }
//                        }
//                        .padding(10)
//                    }
//                    .background(Color(red: 240/255, green: 247/255, blue: 255/255))
//                }
//                .cornerRadius(20)
//
//                Text(meal.strInstructions)
//                    .padding(.top, 10)
//                Text("\(meal.strYoutube)")
//                    .padding(.top, 10)

                Spacer()
            }
            .padding([.leading, .trailing], 10)

        }
        .onAppear {
            imageLoader.loadImage(with: meal.imageURL)
        }
    }
}
