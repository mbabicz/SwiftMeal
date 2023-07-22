//
//  Meal.swift
//  SwiftMeal
//
//  Created by kz on 04/04/2023.
//

import Foundation

struct Meal: Identifiable, Hashable {
    var id: String
    var name: String
    var description: String
    var price: Double
    var img: String
    var ingredients: [String]
    var nutrition: [String]
    var category: String
    
    var imageURL: URL {
        URL(string: img)!
    }
    
    var formattedPrice : String{
        return String(format: "%.2f$", price)
    }
    
}
