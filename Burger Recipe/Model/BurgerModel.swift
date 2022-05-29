//
//  BurgerModel.swift
//  Burger Recipe
//
//  Created by Vladimir Todorov on 21.12.21.
//

import Foundation
import CoreData
import UIKit

class BurgerModel {
    
   private(set) var burgers: [Burger] = []
    
    let context: NSManagedObjectContext
    
    init() {
        
        context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        do {
            if try context.count(for: Burger.fetchRequest()) == 0 {
                if let url = Bundle.main.url(forResource: "BurgerResources/burgers", withExtension: "json") {
                    let data = try Data(contentsOf: url)
                   let jsonBurgers = try JSONDecoder().decode([BurgerJSON].self, from: data)
                    jsonBurgers.forEach { burger in
                        let newBurger = Burger(name: burger.name, ingredients: burger.ingredients, image: UIImage(named: burger.imageName), thumbnail: UIImage(named: burger.thumbnailName), type: burger.type, context: context)
                            burgers.append(newBurger)
                    }
                    try context.save()
                }
            } else {
                burgers = try context.fetch(Burger.fetchRequest())
            }
            
        } catch {
            
        }
    }
    
    func burgers(forType type: BurgerType?) -> [Burger] {
        guard let type = type else { return burgers }
        return burgers.filter { $0.burgerType == type.rawValue }
    }
    
    func add(burger: Burger) {
        burgers.append(burger)
        try? context.save()
    }
}

