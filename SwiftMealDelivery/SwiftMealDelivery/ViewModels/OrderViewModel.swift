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

    func fetchActiveOrders() {
        getActiveOrders { [weak self] orders in
            DispatchQueue.main.async {
                self?.activeOrders = orders
            }
        }
    }

    private func getActiveOrders(completion: @escaping ([Order]) -> Void) {
        let ordersRef = db.collection("Users")
        ordersRef.getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error getting orders: \(error.localizedDescription)")
                completion([])
                return
            }

            var activeOrders: [Order] = []

            let group = DispatchGroup()
            for document in querySnapshot?.documents ?? [] {
                let userOrdersRef = document.reference.collection("Orders")
                let query = userOrdersRef.whereField("isActive", isEqualTo: true).whereField("status", isEqualTo: 1)

                group.enter()

                query.addSnapshotListener { (snapshot, error) in
                    if let error = error {
                        print("Error getting orders: \(error.localizedDescription)")
                        group.leave()
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
                        let order = Order(id: document.documentID, date: date, products: products, status: status, totalPrice: totalPrice, isActive: isActive)
                        activeOrders.append(order)
                    }

                    group.leave()
                }
            }

            group.notify(queue: .main) {
                // Remove duplicates from activeOrders
                let uniqueOrders = self.removeDuplicates(from: activeOrders)
                completion(uniqueOrders)
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
}
