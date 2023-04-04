//
//  Meal.swift
//  SwiftMeal
//
//  Created by kz on 04/04/2023.
//

import Foundation

struct Meal: Codable {
    let id: String
    let name: String
    let category: String
    let area: String
    let instructions: String
    let thumbnail: URL
    let tags: [String]?
    let youtubeLink: URL
    let ingredients: [Ingredient]
}

struct Ingredient: Codable {
    let name: String
    let quantity: String
}
