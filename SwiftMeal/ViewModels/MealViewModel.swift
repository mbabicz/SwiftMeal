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

class MealViewModel: ObservableObject {
    @Published var meals: [Meal]?
    @Published var cartMeals: [Meal: Int] = [:]
    
    @Published var totalCartPrice = 0.0
    private let db = Firestore.firestore()
    private let defaultImage = "https://firebasestorage.googleapis.com/v0/b/swiftmeal-26927.appspot.com/o/pl-default-home_default.jpg?alt=media&token=e55410a7-d06f-4d9d-aebf-41eacb504642"
    private let container: NSPersistentContainer
    private let context: NSManagedObjectContext
    
    init() {
        container = NSPersistentContainer(name: "CartMeal")
        container.loadPersistentStores { (_, error) in
            if let error = error {
                fatalError("Error: \(error.localizedDescription)")
            }
        }
        context = container.viewContext
    }
    
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
    
    
    func addToCart(_ productID: String, _ quantity: Int) {
        let entity = NSEntityDescription.entity(forEntityName: "CartMeal", in: context)!
        let cartMeal = NSManagedObject(entity: entity, insertInto: context)
        cartMeal.setValue(productID, forKey: "id")
        cartMeal.setValue(quantity, forKey: "quantity")
        do {
            try context.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        fetchCartMeals()
    }
    
    func fetchCartMeals() {
        DispatchQueue.global(qos: .background).async {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CartMeal")
            do {
                let result = try self.context.fetch(fetchRequest)
                var cartMeals = [Meal: Int]()
                for data in result as! [NSManagedObject] {
                    if let id = data.value(forKey: "id") as? String,
                       let quantity = data.value(forKey: "quantity") as? Double,
                       let meal = self.meals?.first(where: { $0.id == id }) {
                        if let count = cartMeals[meal] {
                            cartMeals[meal] = count + Int(quantity)
                        } else {
                            cartMeals[meal] = Int(quantity)
                        }
                    }
                }
                DispatchQueue.main.async {
                    self.cartMeals = cartMeals
                    self.calculateTotalPrice()
                }
            } catch let error as NSError {
                print("Could not fetch. \(error), \(error.userInfo)")
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
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CartMeal")
        fetchRequest.predicate = NSPredicate(format: "id = %@", mealID)
        do {
            let cartMeals = try context.fetch(fetchRequest)
            for cartMeal in cartMeals {
                context.delete(cartMeal as! NSManagedObject)
            }
            try context.save()
            fetchCartMeals()
        } catch let error as NSError {
            print("Could not delete. \(error), \(error.userInfo)")
        }
    }
}
