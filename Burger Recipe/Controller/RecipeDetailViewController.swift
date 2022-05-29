//
//  RecipeDetailViewController.swift
//  Burger Recipe
//
//  Created by Vladimir Todorov on 1.01.22.
//

import UIKit

class RecipeDetailViewController: UIViewController {
    
    @IBOutlet weak var bannerImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ingredientsTextView: UITextView!
    
    var burger: Burger!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bannerImageView.image = burger.bannerImage
        nameLabel.text = burger.name
        ingredientsTextView.text = bulletedList(forIngredients: burger.ingredients!)

    }
    
    private func bulletedList(forIngredients ingredients: String) -> String {
        var list = ""
        let items = ingredients.split(separator: ",")
        items.forEach { list.append("\u{2022} \($0)\n") }
        return list
    }

}
