//
//  SwiftMealDeliveryApp.swift
//  SwiftMealDelivery
//
//  Created by mbabicz on 14/07/2023.
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
struct SwiftMealDeliveryApp: App {

    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    var body: some Scene {
        WindowGroup {
            let orderVM = OrderViewModel()

            ContentView()
                .environmentObject(orderVM)
        }
    }
}
