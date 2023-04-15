//
//  MealViewModel.swift
//  SwiftMeal
//
//  Created by kz on 04/04/2023.
//

import Foundation
import FirebaseFirestore
import Firebase

class MealViewModel: ObservableObject {
    @Published var meals: [Meal]?
    @Published var cartMeals: [Meal: Int] = [:]
    @Published var totalCartPrice = 0.0
    private let db = Firestore.firestore()
    private let defaultImage = "https://firebasestorage.googleapis.com/v0/b/swiftmeal-26927.appspot.com/o/pl-default-home_default.jpg?alt=media&token=e55410a7-d06f-4d9d-aebf-41eacb504642"
    
    func fetchMeals(){
        self.meals = nil
        db.collection("Meals").getDocuments { snapshot, error in
            guard error == nil else {
                print("Error: can't get meals from database")
                return
            }
            guard let snapshot = snapshot else { return }
            DispatchQueue.main.async {
                
                self.meals = snapshot.documents.compactMap { doc -> Meal? in
                    let name = doc["name"] as? String ?? ""
                    let id = doc.documentID
                    let img = doc["img"] as? String ?? self.defaultImage
                    let price = doc["price"] as? Double ?? 0
                    let description = doc["description"] as? String ?? ""
                    let category = doc["category"] as? String ?? ""
                    let ingredients = doc["ingredients"] as? [String] ?? []
                    let nutrition = doc["nutrition"] as? [String] ?? []

                    return Meal(id: id, name: name, description: description, price: price, img: img, ingredients: ingredients, nutrition: nutrition, category: category)
                }
            }
        }
    }

    func addToCart(_ productID: String) {
        if let meal = meals?.first(where: { $0.id == productID }) {
            if let count = cartMeals[meal] {
                cartMeals[meal] = count + 1
            } else {
                cartMeals[meal] = 1
            }
            self.calculateTotalPrice()
        }
    }
    
    func calculateTotalPrice(){
        var totalPrice = 0.0
        for (meal, count) in cartMeals{
            totalPrice += meal.price * Double(count)
        }
        self.totalCartPrice = totalPrice
    }

}
