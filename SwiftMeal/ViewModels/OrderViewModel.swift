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
    let userID = Auth.auth().currentUser?.uid
    
    func submitOrder(mealQuantities: [String:Int], totalPrice: Double, completion: @escaping () -> Void) {
        let orderRef = db.collection("Users").document(userID!).collection("Orders").document()
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
    
    func getAllOrders(completion: @escaping ([Order]) -> Void) {
        guard let userID = Auth.auth().currentUser?.uid else { return }
        let ordersRef = db.collection("Users").document(userID).collection("Orders")
        
        ordersRef.getDocuments { (snapshot, error) in
            if let error = error {
                print("Error getting orders: \(error.localizedDescription)")
                return
            }
            
            var orders: [Order] = []
            
            for document in snapshot?.documents ?? [] {
                guard let date = document.data()["date"] as? Timestamp,
                      let products = document.data()["products"] as? [String: Int],
                      let status = document.data()["status"] as? String,
                      let totalPrice = document.data()["totalPrice"] as? Double else {
                    continue
                }
                
                let order = Order(id: document.documentID, date: date, products: products, status: status, totalPrice: totalPrice)
                orders.append(order)
            }
            
            completion(orders)
        }
    }



    
}
