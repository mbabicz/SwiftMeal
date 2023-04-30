//
//  Order.swift
//  SwiftMeal
//
//  Created by kz on 25/04/2023.
//

import Foundation
import Firebase


struct Order: Identifiable, Hashable {
    let id: String
    let date: Timestamp
    let products: [String: Int]
    let status: String
    let totalPrice: Double
    let isActive: Bool
    
    var formattedTotalPrice : String{
        return String(format: "%.2f$", totalPrice)
    }
}
