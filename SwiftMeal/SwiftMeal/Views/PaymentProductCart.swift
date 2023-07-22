//
//  PaymentProductCart.swift
//  SwiftMeal
//
//  Created by kz on 25/04/2023.
//

import SwiftUI

struct PaymentProductCart: View {
    
    var meal: Meal
    @State var quantity: Int
    @StateObject private var imageLoader = ImageLoader()
    
    var body: some View {
        HStack{
            if let image = imageLoader.image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 40)
                    .cornerRadius(20)
                    .padding(.leading, 30)
            }
            VStack(alignment: .leading){
                HStack{
                    Text(meal.name)
                    Text("x\(quantity)")
                }
                Text("Cost: \(String(format: "%.2f$", meal.price * Double(quantity)))")
            }
            .padding(.leading, 20)

            Spacer()
        }
        .frame(maxWidth: .infinity)
        .onAppear {
            imageLoader.loadImage(with: meal.imageURL)
        }
    }
}
