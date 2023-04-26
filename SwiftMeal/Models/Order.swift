//
//  Order.swift
//  SwiftMeal
//
//  Created by kz on 25/04/2023.
//

import Foundation


struct Order: Identifiable, Hashable {
    var id: String
    var mealIDs: [String]
    var date: Date
    var status: String
    var totalPrice: Double
    
    var formattedTotalPrice : String{
        return String(format: "%.2f$", totalPrice)
    }
    
}
