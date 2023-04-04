//
//  MainView.swift
//  SwiftMeal
//
//  Created by kz on 04/04/2023.
//

import SwiftUI

struct MainView: View {
    
    @ObservedObject var mealViewModel = MealViewModel()
    
    @State var searchText = ""

    var body: some View {
        NavigationView{
            VStack{
                if mealViewModel.meal != nil {
                    MealCard(meal: (mealViewModel.meal!))
                }
            }
//            VStack{
//                Text(mealViewModel.meal?.strMeal ?? "")
//            }
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
