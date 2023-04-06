//
//  MainView.swift
//  SwiftMeal
//
//  Created by kz on 04/04/2023.
//

import SwiftUI

enum Category: String, CaseIterable {
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
    
    @State var searchText = ""
    @State var selectedCategory: Category = .Beef

    var body: some View {
        NavigationView{
            VStack(alignment: .leading, spacing: 0){
                if mealViewModel.meal != nil {
                    NavigationLink(destination: MealDetailsView(meal: (mealViewModel.meal!))){
                        MealCard(meal: (mealViewModel.meal!))
                    }
                }
                Text("Categories")
                    .padding(.horizontal, 20)
                    .font(.title)
                    .bold()
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 10) {
                        ForEach(Category.allCases, id: \.self) { category in
                            Button(action: {
                                self.selectedCategory = category
                            }) {
                                Text(category.rawValue)
                                    .font(.callout)
                                    .foregroundColor(category == selectedCategory ? .white : .black)
                                    .padding(.vertical, 10)
                                    .padding(.horizontal, 20)
                                    .background(category == selectedCategory ? Color.blue : Color.gray.opacity(0.4))
                                    .cornerRadius(25)
                            }
                        }
                    }
                    .padding(.horizontal)
                    
                    Spacer()
                }
                .padding(.vertical, 10)
            }
            .onChange(of: searchText) { searchText in
                mealViewModel.searchMealByName(name: searchText)
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
