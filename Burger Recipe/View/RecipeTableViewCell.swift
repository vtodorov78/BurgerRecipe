//
//  RecipeTableViewCell.swift
//  Burger Recipe
//
//  Created by Vladimir Todorov on 8.01.22.
//

import UIKit

class RecipeTableViewCell: UITableViewCell {

    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ingredientsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        thumbnailImageView.layer.cornerRadius = 4
    }
}
