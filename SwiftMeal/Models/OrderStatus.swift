//
//  OrderStatus.swift
//  SwiftMeal
//
//  Created by mbabicz on 13/07/2023.
//

import Foundation

enum OrderStatus: Int {
    case ordered = 0
    case delivery = 1
    case done = 2

    var name: String {
        switch self {
        case .ordered:
            return "Ordered"
        case .delivery:
            return "Delivery"
        case .done:
            return "Done"
        }
    }
}
