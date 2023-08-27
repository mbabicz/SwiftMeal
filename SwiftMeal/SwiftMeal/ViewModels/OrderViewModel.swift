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
    @Published var orders: [Order] = []
    @Published var activeCount = 0

    
    func submitOrder(mealQuantities: [String:Int], totalPrice: Double, completion: @escaping () -> Void) {
        let orderRef = db.collection("Users").document(userID!).collection("Orders").document()
        let data: [String: Any] = [
            "date": Timestamp(date: Date()),
            "products": mealQuantities,
            "status": OrderStatus.ordered.rawValue,
            "isActive": true,
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

    func getAllOrders() {
        let ordersRef = db.collection("Users").document(userID!).collection("Orders")
        ordersRef.addSnapshotListener { (snapshot, error) in
            if let error = error {
                print("Error getting orders: \(error.localizedDescription)")
                return
            }
            self.activeCount = 0
            self.orders.removeAll(keepingCapacity: false)

            for document in snapshot?.documents ?? [] {
                guard let timestamp = document.data()["date"] as? Timestamp,
                      let products = document.data()["products"] as? [String: Int],
                      let statusInt = document.data()["status"] as? Int,
                      let status = OrderStatus(rawValue: statusInt),
                      let isActive = document.data()["isActive"] as? Bool,
                      let totalPrice = document.data()["totalPrice"] as? Double,
                      let locationArray = document.data()["location"] as? [Double],
                      locationArray.count == 2 else {
                        continue
                }

                let latitude = locationArray[0]
                let longitude = locationArray[1]

                let date = timestamp.dateValue()
                let order = Order(
                    id: document.documentID,
                    date: date,
                    products: products,
                    status: status,
                    totalPrice: totalPrice,
                    isActive: isActive,
                    orderedBy: self.userID,
                    latitude: latitude,
                    longitude: longitude
                )
                self.orders.append(order)

                if isActive {
                    self.activeCount += 1
                }
            }
        }
    }

    
}
