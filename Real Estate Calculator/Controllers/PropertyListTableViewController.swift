//
//  PropertyListTableViewController.swift
//  Real Estate Calculator
//
//  Created by Alex Mendes on 4/25/19.
//  Copyright © 2019 Alex Mendes. All rights reserved.
//

import UIKit

class PropertyListTableViewController: UITableViewController {

    // MARK: - Declared Variebles
    var selectedProperty: Property?
    var listTableViewCell = ListTableViewCell()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = selectedProperty?.streetAddress

    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listTableViewCell.listCells.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ListTableViewCell
        cell.prepareCell(with: indexPath)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0  { performSegue(withIdentifier: "fixFlipSegue", sender: nil) }
        else if indexPath.row == 1  { performSegue(withIdentifier: "rentalSegue", sender: nil)}
        else if indexPath.row == 2  { performSegue(withIdentifier: "mortgageSegue", sender: nil)}
        else if indexPath.row == 3  { performSegue(withIdentifier: "propertyInfoSegue", sender: nil) }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let destinationVC0 = segue.destination as? FixAndFlipViewController {
            destinationVC0.property = selectedProperty
            
        } else if let destinationVC1 = segue.destination as? RentalViewController {
            destinationVC1.property = selectedProperty
            
        } else if let destinationVC1 = segue.destination as? MortgageViewController {
            destinationVC1.property = selectedProperty
            
        } else if let destinationVC2 = segue.destination as? AddEdditViewController {
            destinationVC2.property = selectedProperty
        }
    }
}
