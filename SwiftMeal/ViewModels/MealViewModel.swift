//
//  MealViewModel.swift
//  SwiftMeal
//
//  Created by kz on 04/04/2023.
//

import Foundation
import FirebaseFirestore
import Firebase
import CoreData
import FirebaseAuth

class MealViewModel: ObservableObject {
    
    @Published var meals: [Meal]?
    @Published var cartMeals: [Meal: Int] = [:]
    
    @Published var totalCartPrice = 0.0
    private let defaultImage = "https://firebasestorage.googleapis.com/v0/b/swiftmeal-26927.appspot.com/o/pl-default-home_default.jpg?alt=media&token=e55410a7-d06f-4d9d-aebf-41eacb504642"
    
    private let db = Firestore.firestore()
    private let auth = Auth.auth()
    var uuid: String? {
        return auth.currentUser?.uid
    }
    
    func fetchMeals(){
        self.meals = nil
        self.db.collection("Meals").getDocuments { snapshot, error in
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
    
    func addToCart(_ productID: String, _ quantity: Int) {
        
        let userRef = self.db.collection("Users").document(self.uuid!)
        
        userRef.getDocument { (document, error) in
            if let document = document, document.exists {
                //Get current cart
                var cart = document.data()?["cart"] as? [String: Int] ?? [:]
                
                // Add new product to cart or change the quantity
                if let currentQuantity = cart[productID] {
                    cart[productID] = currentQuantity + quantity
                } else {
                    cart[productID] = quantity
                }
                
                userRef.updateData(["cart": cart]) { error in
                    if let error = error {
                        print("Error: \(error.localizedDescription)")
                    } else {
                        self.fetchCartMeals()
                    }
                }
            }
        }
    }
    
    func fetchCartMeals() {
        
        let userRef = self.db.collection("Users").document(self.uuid!)
        
        userRef.getDocument { document, error in
            guard let document = document, document.exists,
                  let documentData = document.data(),
                  let cartMeals = documentData["cart"] as? [String: Int] else {
                return
            }
            let meals = cartMeals.compactMap { id, quantity -> Meal? in
                return self.meals?.first(where: { $0.id == id })
            }
            var cartMealsDict: [Meal: Int] = [:]
            for meal in meals {
                if let quantity = cartMeals[meal.id] {
                    cartMealsDict[meal] = quantity
                }
            }
            DispatchQueue.main.async {
                self.cartMeals = cartMealsDict
                self.calculateTotalPrice()
            }
        }
    }
    
    func calculateTotalPrice(){
        var totalPrice = 0.0
        for (meal, count) in cartMeals{
            totalPrice += meal.price * Double(count)
        }
        self.totalCartPrice = totalPrice
    }
    
    func removeMealFromCart(_ mealID: String) {
        let userRef = self.db.collection("Users").document(self.uuid!)
        userRef.getDocument { document, error in
            if let document = document, document.exists,
               var documentData = document.data(),
               var cartMeals = documentData["cart"] as? [String: Int] {
                cartMeals[mealID] = nil
                documentData["cart"] = cartMeals
                userRef.setData(documentData) { error in
                    if let error = error {
                        print("Error updating document: \(error)")
                    } else {
                        print("Document successfully updated")
                        self.fetchCartMeals()
                    }
                }
            }
        }
    }
    
    func updateQuantity(_ productID: String, _ newQuantity: Int) {
        let userRef = self.db.collection("Users").document(self.uuid!)
        
        userRef.updateData([
            "cart.\(productID)": newQuantity
        ]) { error in
            if let error = error {
                print("Cant update cart: \(error.localizedDescription)")
            } else {
                self.fetchCartMeals()
            }
        }
    }

}
