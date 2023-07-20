//
//  OrderViewModel.swift
//  SwiftMealDelivery
//
//  Created by mbabicz on 20/07/2023.
//

import Foundation
import FirebaseFirestore
import SwiftUI

class OrderViewModel: ObservableObject {
    
    private let db = Firestore.firestore()
    @Published var activeOrders: [Order] = []


    func getActiveOrders() {
        let ordersRef = db.collection("Users")
        ordersRef.getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error getting orders: \(error.localizedDescription)")
                return
            }
            self.activeOrders.removeAll(keepingCapacity: false)

            for document in querySnapshot?.documents ?? [] {
                let userOrdersRef = document.reference.collection("Orders")
                let query = userOrdersRef.whereField("isActive", isEqualTo: true).whereField("status", isEqualTo: 1)

                query.addSnapshotListener { (snapshot, error) in
                    if let error = error {
                        print("Error getting orders: \(error.localizedDescription)")
                        return
                    }

                    // Clear activeOrders before appending new data to avoid duplicates
                    self.activeOrders.removeAll(keepingCapacity: false)

                    for document in snapshot?.documents ?? [] {
                        guard let timestamp = document.data()["date"] as? Timestamp,
                              let products = document.data()["products"] as? [String: Int],
                              let statusInt = document.data()["status"] as? Int,
                              let status = OrderStatus(rawValue: statusInt),
                              let isActive = document.data()["isActive"] as? Bool,
                              let totalPrice = document.data()["totalPrice"] as? Double else {
                            continue
                        }

                        let date = timestamp.dateValue()
                        let order = Order(id: document.documentID, date: date, products: products, status: status, totalPrice: totalPrice, isActive: isActive)
                        self.activeOrders.append(order)
                    }
                }
            }
        }
    }


    
}
