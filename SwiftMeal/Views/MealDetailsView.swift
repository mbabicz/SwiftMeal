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
    @EnvironmentObject var mealViewModel: MealViewModel
    @State private var stepperValue = 1
    
    @Environment(\.presentationMode) var presentationMode
    @Binding var showConfirmation: Bool
    
    var body: some View {
        ZStack{
            ScrollView{
                Text(meal.name)
                    .font(.title)
                    .bold()
                    .padding(.top)
                Text(meal.formattedPrice)
                    .font(.headline)
                    .padding(.trailing, 20)
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
                        
                        HStack(alignment: .center){
                            
                            CustomStepper(stepperValue: $stepperValue)
                            Spacer()
                            
                            Button {
                                mealViewModel.addToCart(meal.id, stepperValue)
                                self.presentationMode.wrappedValue.dismiss()
                                withAnimation(){
                                    self.showConfirmation = true
                                }
                            } label: {
                                HStack() {
                                    Image(systemName: "cart.badge.plus")
                                        .bold().font(.callout)
                                    Text("Add to cart: \(String(format: "%.2f$", meal.price * Double(stepperValue)))")
                                        .bold().font(.callout)
                                }
                                .padding(8)
                                .foregroundColor(.white)
                                .background(Color.green)
                                .cornerRadius(45)
                            }
                        }
                        .padding([.bottom, .horizontal])
                        
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
                            .padding(.bottom, 50)
                        Spacer()
                    }
                }
                Spacer()
            }
            
            VStack{
                Spacer()
                
                if !mealViewModel.cartMeals.isEmpty {
                    NavigationLink(destination: CartView()) {
                        HStack() {
                            Image(systemName: "cart.fill")
                                .bold().font(.callout)
                            Text("Go to cart: \(String(format: "%.2f", mealViewModel.totalCartPrice))$")
                                .bold().font(.callout)
                        }
                        .padding(8)
                        .foregroundColor(.white)
                        .background(Color.purple)
                        .cornerRadius(45)
                        .shadow(radius: 10)
                    }
                }
            }
        }
        .onAppear {
            imageLoader.loadImage(with: meal.imageURL)
        }
        
    }
}
