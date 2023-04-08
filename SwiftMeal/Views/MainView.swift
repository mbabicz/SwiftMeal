//
//  MainView.swift
//  SwiftMeal
//
//  Created by kz on 04/04/2023.
//

import SwiftUI


enum Category: String, CaseIterable {
    case all = "All"
    case Beef = "Beef"
    case Chicken = "Chicken"
    case Dessert = "Dessert"
    case Lamb = "Lamb"
    case Miscellaneous = "Miscellaneous"
    case Pasta = "Pasta"
    case Pork = "Pork"
    case Seafood = "Seafood"
    case Side = "Side"
    case Starter = "Starter"
    case Vegan = "Vegan"
    case Vegetarian = "Vegetarian"
    case Breakfast = "Breakfast"
    case Goat = "Goat"
}

struct MainView: View {
    
    @ObservedObject var mealViewModel = MealViewModel()
    
    @State private var searchText = ""
    @State private var selectedCategory: Category = .all
    
    var body: some View {
        NavigationView{
            VStack(alignment: .leading, spacing: 0){
                if mealViewModel.meals != nil{
                    ForEach(mealViewModel.meals!, id: \.self){ meal in
                        NavigationLink(destination: MealDetailsView(meal: meal)){
                            MealCard(meal: meal)
                        }
                    }
                }
            }
            .onAppear{
                mealViewModel.fetchMeals()
            }
        }
        .searchable(text: $searchText)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

//                if searchText != "" {
//                    if let meal = mealViewModel.meals {
//                        NavigationLink(destination: MealDetailsView(meal: meal)){
//                            MealCard(meal: meal)
//                        }
//                    }
//                } else {
//                    Text("Categories")
//                        .font(.title)
//                        .bold()
//                        .padding(.horizontal, 20)
//
//                    ScrollView(.horizontal, showsIndicators: false) {
//                        HStack(spacing: 10) {
//                            ForEach(Category.allCases, id: \.self) { category in
//                                Button(action: {
//                                    selectedCategory = category
//                                    //mealViewModel.searchMealByCategory(name: category.rawValue)
//                                }) {
//                                    Text(category.rawValue)
//                                        .font(.callout)
//                                        .foregroundColor(selectedCategory == category ? .white : .black)
//                                        .padding(.vertical, 10)
//                                        .padding(.horizontal, 20)
//                                        .background(selectedCategory == category ? Color.blue : Color.gray.opacity(0.4))
//                                        .cornerRadius(25)
//                                }
//                            }
//                        }
//                        .padding(.horizontal)
//
//                        Spacer()
//                    }
//                    .padding(.vertical, 10)
//                }
//
//            }
//            .onChange(of: searchText) { searchText in
//                mealViewModel.searchMealByName(name: searchText)
//            }
