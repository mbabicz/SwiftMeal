//
//  OrderViewModel.swift
//  SwiftMeal
//
//  Created by kz on 25/04/2023.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class OrderViewModel: ObservableObject {
    
    private let db = Firestore.firestore()
    
    func submitOrder(mealIDs: [String], totalPrice: Double) {
        
        guard let userID = Auth.auth().currentUser?.uid else { return }
        
        let orderRef = db.collection("Users").document(userID).collection("Orders").document()

        let data: [String: Any] = [
            "date": Timestamp(date: Date()),
            "productIDs": mealIDs,
            "status": "Ordered",
            "totalPrice": totalPrice
        ]
        
        orderRef.setData(data) { (error) in
            if let error = error {
//                self.updateAlert(title: "Error", message: error.localizedDescription)
            } else {
//                self.updateAlert(title: "Success", message: "Zamówienie złożone pomyślnie")
                for meal in mealIDs {
//                    self.db.collection("Users").document(userID).collection("Cart").document(product).delete()
                }
//                self.getUserCart()
            }
        }
    }
    
}
