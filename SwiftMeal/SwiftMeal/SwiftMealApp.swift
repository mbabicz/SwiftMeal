//
//  SwiftMealApp.swift
//  SwiftMeal
//
//  Created by kz on 03/04/2023.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        
        return true
    }
}

@main
struct SwiftMealApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            let mealVM = MealViewModel()
            let userVM = UserViewModel()
            let orderVM = OrderViewModel()


            ContentView()
                .environmentObject(mealVM)
                .environmentObject(userVM)
                .environmentObject(orderVM)

        }
    }
}
