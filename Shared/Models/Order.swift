//
//  Order.swift
//  SwiftMeal
//
//  Created by kz on 25/04/2023.
//

import Foundation
import CoreLocation

struct Order: Identifiable, Hashable {
    let id: String
    let date: Date
    let products: [String: Int]
    let status: OrderStatus
    let totalPrice: Double
    let isActive: Bool
    let orderedBy: String?
    let latitude: Double?
    let longitude: Double?
    
    var formattedTotalPrice : String{
        return String(format: "%.2f$", totalPrice)
    }
    
    var formattedDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy HH:mm"
        return dateFormatter.string(from: self.date)
    }
}

extension Order {
    static var sampleOrder: Order {
        return Order(id: "1", date: Date.now, products: ["RGfj6vb5Iep0PFSmmS5a" : 1], status: .delivery, totalPrice: 3.49, isActive: true, orderedBy: "123", latitude: 53.443206787109375, longitude: 14.484069611811538)
    }
    
    init(id: String, date: Date, products: [String: Int], status: OrderStatus, totalPrice: Double, isActive: Bool, orderedBy: String?) {
        self.id = id
        self.date = date
        self.products = products
        self.status = status
        self.totalPrice = totalPrice
        self.isActive = isActive
        self.orderedBy = orderedBy
        self.latitude = nil
        self.longitude = nil
    }
}
