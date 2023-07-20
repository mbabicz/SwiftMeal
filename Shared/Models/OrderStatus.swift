//
//  OrderStatus.swift
//  SwiftMeal
//
//  Created by mbabicz on 13/07/2023.
//

import Foundation

enum OrderStatus: Int {
    case ordered = 0
    case preparing = 1
    case delivery = 2
    case done = 3

    var name: String {
        switch self {
        case .ordered:
            return "Ordered"
        case .preparing:
            return "Preparing"
        case .delivery:
            return "Delivery"
        case .done:
            return "Done"
        }
    }
}
