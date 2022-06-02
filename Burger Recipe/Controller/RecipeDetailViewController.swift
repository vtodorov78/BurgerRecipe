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
    @IBOutlet weak var favouriteImageView: UIImageView!
    
    var burger: Burger!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(toggleFavourite))
        doubleTap.numberOfTapsRequired = 2
        
        bannerImageView.addGestureRecognizer(doubleTap)
    }
    
    @objc func toggleFavourite() {
        burger.setValue(!burger.favourite, forKey: "favourite")
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        favouriteImageView.isHidden = !burger.favourite
    }
    
    private func bulletedList(forIngredients ingredients: String) -> String {
        var list = ""
        let items = ingredients.split(separator: ",")
        items.forEach { list.append("\u{2022} \($0)\n") }
        return list
    }
    
    private func setupUI() {
        loadViewIfNeeded()
        
        favouriteImageView.isHidden = !burger.favourite
        
        bannerImageView.image = burger.bannerImage
        nameLabel.text = burger.name
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.5
        
        let attributes = [NSAttributedString.Key.font : UIFont.preferredFont(forTextStyle: .body),
                          NSAttributedString.Key.paragraphStyle : paragraphStyle,
                          NSAttributedString.Key.foregroundColor : UIColor.label]
        
        
        ingredientsTextView.attributedText = NSAttributedString(string: bulletedList(forIngredients: burger.ingredients!), attributes: attributes)
    }

}

extension RecipeDetailViewController: RecipeSelectionDelegate {
    
    func burgerSelected(_ burger: Burger) {
        self.burger = burger
        setupUI()
    }
    
    
}
