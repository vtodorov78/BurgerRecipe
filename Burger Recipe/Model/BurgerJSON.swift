//
//  BurgerJSON.swift
//  Burger Recipe
//
//  Created by Vladimir Todorov on 21.12.21.
//

import Foundation

struct BurgerJSON: Decodable {
    let name: String
    let ingredients: String
    let imageName: String
    let thumbnailName: String
    let type: BurgerType
    
}

enum BurgerType: String, Decodable {
    case vegetarian = "vegetarian"
    case meat = "meat"
}
