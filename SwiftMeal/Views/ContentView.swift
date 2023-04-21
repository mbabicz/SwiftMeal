//
//  ContentView.swift
//  SwiftMeal
//
//  Created by kz on 21/04/2023.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var userViewModel: UserViewModel
    @EnvironmentObject var mealViewModel: MealViewModel

    var body: some View {
        NavigationView{
            if !userViewModel.userIsAuthenticatedAndSynced {
                LoadingView()
            } else {
                MainView()
            }
        }
        .accentColor(.black)

        .onAppear{
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                withAnimation{
                    if userViewModel.userIsAuthenticated{
                        userViewModel.syncUser()
                    } else {
                        userViewModel.signInAnonymously()
                    }
                }
            }
            mealViewModel.fetchMeals()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
