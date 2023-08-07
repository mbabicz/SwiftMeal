//
//  OrderViewModel.swift
//  SwiftMealDelivery
//
//  Created by mbabicz on 20/07/2023.
//

import Foundation
import FirebaseFirestore
import SwiftUI
import FirebaseAuth

class OrderViewModel: ObservableObject {
    private let db = Firestore.firestore()
    @Published var activeOrders: [Order] = []
    
    func fetchActiveOrders() {
        let ordersRef = db.collection("Users")
        ordersRef.getDocuments { [weak self] (querySnapshot, error) in
            guard let self = self else { return }

            if let error = error {
                print("Error getting orders: \(error.localizedDescription)")
                return
            }
            
            // Create a copy of the current active orders to avoid race conditions
            var updatedActiveOrders = self.activeOrders

            for document in querySnapshot?.documents ?? [] {
                let userID = document.documentID
                let userOrdersRef = document.reference.collection("Orders")
                
                userOrdersRef.whereField("isActive", isEqualTo: true).whereField("status", isEqualTo: 1).addSnapshotListener { (snapshot, error) in
                    if let error = error {
                        print("Error getting orders: \(error.localizedDescription)")
                        return
                    }
                    
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
                        let order = Order(id: document.documentID, date: date, products: products, status: status, totalPrice: totalPrice, isActive: isActive, orderedBy: userID)

                        // Check if the order already exists in updatedActiveOrders
                        if let existingIndex = updatedActiveOrders.firstIndex(where: { $0.id == order.id }) {
                            updatedActiveOrders[existingIndex] = order
                        } else {
                            updatedActiveOrders.append(order)
                        }
                    }
                    
                    // Filter out orders with changed isActive or status
                    updatedActiveOrders.removeAll { order in
                        let documentID = order.id
                        let matchingDocuments = snapshot?.documents.filter { $0.documentID == documentID }
                        return matchingDocuments?.isEmpty ?? true
                    }
                    
                    // Update the global activeOrders with the updated list
                    self.activeOrders = updatedActiveOrders
                }
            }
        }
    }

    private func removeDuplicates(from orders: [Order]) -> [Order] {
        var uniqueOrders: [Order] = []
        var orderIDs: Set<String> = []

        for order in orders {
            if !orderIDs.contains(order.id) {
                uniqueOrders.append(order)
                orderIDs.insert(order.id)
            }
        }

        return uniqueOrders
    }
    
    func updateOrder(orderID: String, userID: String, status: Int /*coordinates: [Double]?*/) {
        let orderRef = db.collection("Users").document(userID).collection("Orders").document(orderID)
        
        let orderData: [String: Any] = [
            "isActive": false,
            "status": status,
            "deliveryBy": Auth.auth().currentUser?.uid ?? ""
        ]
        
//        if let coordinates = coordinates {
//            orderData["coordinates"] = coordinates
//        }
        
        orderRef.setData(orderData, merge: true) { error in
            if let error = error {
                print("Error updating order: \(error.localizedDescription)")
                return
            }
        }
    }

}
