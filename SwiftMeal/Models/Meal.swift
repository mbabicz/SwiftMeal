//
//  Product.swift
//  SwiftMeal
//
//  Created by kz on 04/04/2023.
//

import Foundation

struct Meal: Identifiable {
    var id: String
    var name: String
    var img: String
    var price: Int
    var description: String
    
    var ingredients : [String]
}

extension Meal{
    var imageURL: URL {
        URL(string: img)!
    }
    
    static var sampleMeals: [Meal] {
        return [
            Meal(id: "1", name: "Classic Beef Burger" , img: "https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.istockphoto.com%2Ffr%2Fphoto%2Fburger-avec-fromage-gm945057664-258136264&psig=AOvVaw2ZnLEroVeEjNDDX0ad1ohW&ust=1680684756871000&source=images&cd=vfe&ved=0CBAQjRxqFwoTCLDnjuLsj_4CFQAAAAAdAAAAABAQ", price: 10, description: "This juicy burger features a succulent beef patty cooked to perfection and served on a toasted bun. Topped with fresh, crispy lettuce, sliced onion, tangy pickles, and ripe tomato, it's a delicious classic that never goes out of style. Satisfy your cravings with the perfect combination of savory and refreshing flavors.", ingredients: ["es" , "esy"]),
            Meal(id: "2", name: "Classic Beef Burger" , img: "https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.istockphoto.com%2Ffr%2Fphoto%2Fburger-avec-fromage-gm945057664-258136264&psig=AOvVaw2ZnLEroVeEjNDDX0ad1ohW&ust=1680684756871000&source=images&cd=vfe&ved=0CBAQjRxqFwoTCLDnjuLsj_4CFQAAAAAdAAAAABAQ", price: 10, description: "This juicy burger features a succulent beef patty cooked to perfection and served on a toasted bun. Topped with fresh, crispy lettuce, sliced onion, tangy pickles, and ripe tomato, it's a delicious classic that never goes out of style. Satisfy your cravings with the perfect combination of savory and refreshing flavors.", ingredients: ["es" , "esy"]),
            Meal(id: "3", name: "Classic Beef Burger" , img: "https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.istockphoto.com%2Ffr%2Fphoto%2Fburger-avec-fromage-gm945057664-258136264&psig=AOvVaw2ZnLEroVeEjNDDX0ad1ohW&ust=1680684756871000&source=images&cd=vfe&ved=0CBAQjRxqFwoTCLDnjuLsj_4CFQAAAAAdAAAAABAQ", price: 10, description: "This juicy burger features a succulent beef patty cooked to perfection and served on a toasted bun. Topped with fresh, crispy lettuce, sliced onion, tangy pickles, and ripe tomato, it's a delicious classic that never goes out of style. Satisfy your cravings with the perfect combination of savory and refreshing flavors.", ingredients: ["es" , "esy"])]
    }
    
    static var sampleMeal: Meal {
        return Meal(id: "1", name: "Classic Beef Burger" , img: "https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.istockphoto.com%2Ffr%2Fphoto%2Fburger-avec-fromage-gm945057664-258136264&psig=AOvVaw2ZnLEroVeEjNDDX0ad1ohW&ust=1680684756871000&source=images&cd=vfe&ved=0CBAQjRxqFwoTCLDnjuLsj_4CFQAAAAAdAAAAABAQ", price: 10, description: "This juicy burger features a succulent beef patty cooked to perfection and served on a toasted bun. Topped with fresh, crispy lettuce, sliced onion, tangy pickles, and ripe tomato, it's a delicious classic that never goes out of style. Satisfy your cravings with the perfect combination of savory and refreshing flavors.", ingredients: ["es" , "esy"])
    }


}
