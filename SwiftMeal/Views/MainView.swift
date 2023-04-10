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
        }
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
