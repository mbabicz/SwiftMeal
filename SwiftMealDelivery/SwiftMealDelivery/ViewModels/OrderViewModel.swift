//
//  OrderViewModel.swift
//  SwiftMealDelivery
//
//  Created by mbabicz on 20/07/2023.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseFirestore
import CoreLocation


class OrderViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let db = Firestore.firestore()
    @Published var activeOrders: [Order] = []
    @Published var userOrders: [Order] = []
    private let auth = Auth.auth(app: FirebaseApp.app(name: "SwiftMealDelivery")!)
    
    private let locationManager = CLLocationManager()

    override init() {
        super.init()
        setupLocationManager()
    }

    func setupLocationManager() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func fetchActiveOrders() {
        self.activeOrders.removeAll(keepingCapacity: false)
        let ordersRef = db.collection("Users")
        ordersRef.getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error getting orders: \(error.localizedDescription)")
                return
            }

            for document in querySnapshot?.documents ?? [] {
                let userID = document.documentID
                let userOrdersRef = document.reference.collection("Orders")

                userOrdersRef.addSnapshotListener { (snapshot, error) in
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

                        if isActive == true && status == .preparing {
                            self.activeOrders.append(order)
                        } else {
                            if let index = self.activeOrders.firstIndex(where: { $0.id == order.id }) {
                                self.activeOrders.remove(at: index)
                            }
                        }
                    }
                }
            }
        }
    }
    
    func fetchUserOrders() {
        let ordersRef = db.collection("Users")
        ordersRef.getDocuments { [weak self] (querySnapshot, error) in
            if let error = error {
                print("Error getting orders: \(error.localizedDescription)")
                return
            }

            for document in querySnapshot?.documents ?? [] {
                let userID = document.documentID
                let userOrdersRef = document.reference.collection("Orders")

                userOrdersRef.whereField("deliveryBy", isEqualTo: self?.auth.currentUser!.uid ?? "").whereField("isActive", isEqualTo: false).getDocuments { (snapshot, error) in
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

                        // Check if new element already exists
                        if !(self?.userOrders.contains { $0.id == order.id } ?? false) {
                            self?.userOrders.append(order)
                        }
                    }
                }
            }
        }
        self.updateLocation()
    }

    
    func updateOrder(orderID: String, userID: String, status: Int) {
        let orderRef = db.collection("Users").document(userID).collection("Orders").document(orderID)
        
        let orderData: [String: Any] = [
            "isActive": false,
            "status": status,
            "deliveryBy": auth.currentUser?.uid ?? ""
        ]
        
        orderRef.setData(orderData, merge: true) { error in
            if let error = error {
                print("Error updating order: \(error.localizedDescription)")
                return
            }
            self.fetchUserOrders()
        }
    }


    func updateLocation() {
        if let currentLocation = locationManager.location {
            let latitude = currentLocation.coordinate.latitude
            let longitude = currentLocation.coordinate.longitude
            
            print("Latitude: \(latitude), Longitude: \(longitude)")
            
            let geoPoint = GeoPoint(latitude: latitude, longitude: longitude)
            for order in userOrders {
                let orderRef = db.collection("Users").document(order.orderedBy ?? "").collection("Orders").document(order.id)
                orderRef.updateData(["location": geoPoint]) { error in
                    if let error = error {
                        print("Error updating location for order \(order.id): \(error.localizedDescription)")
                    } else {
                        print("Location updated for order \(order.id)")
                    }
                }
            }
        } else {
            print("Location not available")
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.updateLocation()
    }
}

