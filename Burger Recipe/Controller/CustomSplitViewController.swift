//
//  CustomSplitViewController.swift
//  Burger Recipe
//
//  Created by Vladimir Todorov on 2.06.22.
//

import UIKit

class CustomSplitViewController: UISplitViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        preferredDisplayMode = .oneBesideSecondary
        self.delegate = self
    }

}

extension CustomSplitViewController: UISplitViewControllerDelegate {
    
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        return true
    }
}
