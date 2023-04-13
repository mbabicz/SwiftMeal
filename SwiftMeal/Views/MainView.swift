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
    case pizza = "Pizza"
    case additives = "Additives"
    case drinks = "Drinks"
}

struct MainView: View {
    
    @ObservedObject var mealViewModel = MealViewModel()
    @State private var selectedCategory: Category = .all
    
    var filteredMeals: [Meal] {
        if selectedCategory == .all {
            return mealViewModel.meals ?? []
        } else {
            return mealViewModel.meals?.filter { $0.category == selectedCategory.rawValue.lowercased() } ?? []
        }
    }
    
    var body: some View {
        NavigationView{
            ScrollView{
                Picker(selection: $selectedCategory, label: Text("Select a category")) {
                    ForEach(Category.allCases, id: \.self) { category in
                        Text(category.rawValue).tag(category)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                
                if mealViewModel.meals != nil {
                    LazyVGrid(columns: [
                        GridItem(.flexible()),
                        GridItem(.flexible())
                    ], spacing: 0) {
                        ForEach(filteredMeals, id: \.self) { meal in
                            NavigationLink(destination: MealDetailsView(meal: meal)) {
                                MealCard(meal: meal)
                                    .padding(10)
                            }
                        }
                    }
                }
            }
            .onAppear{
                mealViewModel.fetchMeals()
            }
        }.accentColor(.black)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
