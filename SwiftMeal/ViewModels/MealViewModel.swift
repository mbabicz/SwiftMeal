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
    private let db = Firestore.firestore()
    
    
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
                    let img = doc["img"] as? String ?? ""
                    let price = doc["price"] as? Double ?? 0
                    let description = doc["description"] as? String ?? ""
                    let category = doc["category"] as? String ?? ""
                    let ingredients = doc["ingredients"] as? [String] ?? []
                    
                    return Meal(id: id, name: name, description: description, price: price, img: img, ingredients: ingredients, category: category)


                }
            }
            
        }
    }
}
