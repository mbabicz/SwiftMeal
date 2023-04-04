//
//  MainView.swift
//  SwiftMeal
//
//  Created by kz on 04/04/2023.
//

import SwiftUI

struct MainView: View {
    
    @ObservedObject var mealViewModel = MealViewModel()

    var body: some View {
        VStack{
            Text(mealViewModel.meal?.strMeal ?? "")
        }
        .onAppear {
            mealViewModel.searchMealByName(name: "pizza")
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
