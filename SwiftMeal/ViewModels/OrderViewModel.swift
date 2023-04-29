//
//  OrderViewModel.swift
//  SwiftMeal
//
//  Created by kz on 25/04/2023.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import SwiftUI

class OrderViewModel: ObservableObject {
    
    private let db = Firestore.firestore()
    
    func submitOrder(mealQuantities: [String:Int], totalPrice: Double, completion: @escaping () -> Void) {
        guard let userID = Auth.auth().currentUser?.uid else { return }
        let orderRef = db.collection("Users").document(userID).collection("Orders").document()
        let data: [String: Any] = [
            "date": Timestamp(date: Date()),
            "products": mealQuantities,
            "status": "Ordered",
            "totalPrice": totalPrice
        ]
        
        orderRef.setData(data) { (error) in
            if let error = error {
                print("error: \(error.localizedDescription)")
            } else {
                orderRef.setData(data) { (error) in
                    if let error = error {
                        print("error deleting current cart: \(error.localizedDescription)")
                    } else {
                        completion()
                    }
                }
            }
        }
    }

    
}
