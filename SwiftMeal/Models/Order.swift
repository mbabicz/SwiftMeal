//
//  Order.swift
//  SwiftMeal
//
//  Created by kz on 25/04/2023.
//

import Foundation


struct Order: Identifiable, Hashable {
    let id: String
    let date: Date
    let products: [String: Int]
    let status: String
    let totalPrice: Double
    let isActive: Bool
    
    var formattedTotalPrice : String{
        return String(format: "%.2f$", totalPrice)
    }
    
    var formattedDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy HH:mm"
        return dateFormatter.string(from: self.date)
    }
}
