//
//  RecipesListViewController.swift
//  Burger Recipe
//
//  Created by Vladimir Todorov on 15.12.21.
//

import UIKit

protocol RecipeSelectionDelegate: AnyObject {
    func burgerSelected(_ burger: Burger)
}

class RecipesListViewController: UIViewController {
    
    var model = BurgerModel()
    var selectedType: BurgerType?
    
    weak var delegate: RecipeSelectionDelegate?
    
    @IBOutlet weak var tableView: UITableView!

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableView.automaticDimension
        
        tableView.register(UINib(nibName: "RecipeTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "BurgerCell")
    }
    
    override func viewDidLayoutSubviews() {
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.topAnchor.constraint(equalTo: segmentedControl.superview!.topAnchor).isActive = true
        segmentedControl.bottomAnchor.constraint(equalTo: segmentedControl.superview!.bottomAnchor).isActive = true
        segmentedControl.leftAnchor.constraint(equalTo: segmentedControl.superview!.leftAnchor).isActive = true
        segmentedControl.rightAnchor.constraint(equalTo: segmentedControl.superview!.rightAnchor).isActive = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addRecipe" {
            let navVC = segue.destination as? UINavigationController
            let addVC = navVC?.viewControllers.first as? AddRecipeViewController
            addVC?.delegate = self
            addVC?.context = model.context
        }
    }
    
    @IBAction func didChangeFilter(_ sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
        case 0:
            selectedType = nil
        case 1:
            selectedType = .meat
        case 2:
            selectedType = .vegetarian
        default:
            break
        }
        
        tableView.reloadData()
    }
}

extension RecipesListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.burgers(forType: selectedType).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BurgerCell", for: indexPath) as! RecipeTableViewCell
        let burger = model.burgers(forType: selectedType)[indexPath.row]
        cell.nameLabel?.text = burger.name
        cell.ingredientsLabel?.text = burger.ingredients
        cell.thumbnailImageView?.image = burger.thumbnailImage
        return cell
    }
}

extension RecipesListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let burger = model.burgers[indexPath.row]
        delegate?.burgerSelected(burger)
        
        if let detailVC = delegate as? RecipeDetailViewController {
            splitViewController?.showDetailViewController(detailVC, sender: nil)
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
}

extension RecipesListViewController: AddRecipeDelegate {
    func add(burger: Burger) {
        model.add(burger: burger)
        tableView.reloadData()
    }
}
