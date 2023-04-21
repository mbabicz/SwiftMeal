//
//  MainView.swift
//  SwiftMeal
//
//  Created by kz on 04/04/2023.
//

import SwiftUI

enum Category: String, CaseIterable {
    case all = "All"
    case burgers = "Burgers"
    case additives = "Additives"
    case drinks = "Drinks"
}

struct MainView: View {
    
    @EnvironmentObject var mealViewModel: MealViewModel
    @State private var selectedCategory: Category = .all
    
    @State private var showConfirmation = false
    @State private var showAddedPrice = false
    @State private var addedPrice: Double = 0.0
    
    var filteredMeals: [Meal] {
        if selectedCategory == .all {
            return mealViewModel.meals ?? []
        } else {
            return mealViewModel.meals?.filter { $0.category == selectedCategory.rawValue.lowercased() } ?? []
        }
    }
    
    var body: some View {
        ZStack{
            VStack(spacing: 0){
                ZStack{
                    Picker(selection: $selectedCategory, label: Text("Select a category")) {
                        ForEach(Category.allCases, id: \.self) { category in
                            Text(category.rawValue)
                                .bold()
                                .tag(category)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .background(.white)
                    .cornerRadius(8)
                    .padding([.horizontal, .top])
                }
                Spacer()
            }
            .zIndex(1)
            ScrollView{
                if mealViewModel.meals != nil {
                    LazyVGrid(columns: [
                        GridItem(.flexible()),
                        GridItem(.flexible())
                    ], spacing: 0) {
                        ForEach(filteredMeals, id: \.self) { meal in
                            NavigationLink(destination: MealDetailsView(meal: meal, showConfirmation: $showConfirmation)) {
                                MealCard(meal: meal, showAddedPrice: $showAddedPrice, addedPrice: $addedPrice)
                                    .padding(10)
                            }
                        }
                    }
                    .padding(.bottom, 35)
                    .padding(.top,50)
                }
            }
            .padding(.top, 0.15)                
            
            VStack{
                Spacer() //move the navigation link to the bottom of the screen
                if !mealViewModel.cartMeals.isEmpty {
                    
                    ZStack{
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
                        if showAddedPrice {
                            Text("+\(String(format: "%.2f", self.addedPrice))$")
                                .bold()
                                .transition(.asymmetric(
                                    insertion: AnyTransition.opacity.animation(.easeInOut(duration: 0.3)),
                                    removal: AnyTransition.opacity.animation(.easeInOut(duration: 0.3))
                                ))
                                .onAppear {
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                        self.showAddedPrice = false
                                    }
                                }
                                .offset(x: 125, y: 2)
                        }
                    }
                }
            }
        }
        
        .overlay(
            Group {
                if showConfirmation {
                    VStack {
                        Text("Product successfully added to cart!")
                            .foregroundColor(.white)
                            .padding(12)
                            .background(Color.purple)
                            .cornerRadius(12)
                    }
                    .transition(.asymmetric(
                        insertion: AnyTransition.opacity.animation(.easeInOut(duration: 0.5).delay(0.3)),
                        removal: AnyTransition.opacity.animation(.easeInOut(duration: 0.5))
                    ))
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                            self.showConfirmation = false
                        }
                    }
                }                            
            }
        )
        .onAppear{
            mealViewModel.fetchCartMeals()
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
