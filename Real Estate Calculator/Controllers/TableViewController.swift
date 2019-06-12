//
//  ViewController.swift
//  Real Estate Calculator
//
//  Created by Alex Mendes on 4/24/19.
//  Copyright © 2019 Alex Mendes. All rights reserved.
//

import UIKit
import CoreData

class TableViewController: UITableViewController {
    
    @IBOutlet weak var viewButton: UIView!
    @IBOutlet weak var addNewPropertyButton: UIButton!
    
    // MARK: - DECLARED PROPERTIES:
    var fetchedResultsController: NSFetchedResultsController<Property>!
    var label = UILabel()
    var propertiesArray: [Property] = []
    
    // MARK: - OVERRIDE VIEW FUNCTIONS:
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        loadProperties()
    }
    
    override func viewDidLoad() {
        loadLayout()
    }
    
    // TABLEVIEW DATA SOURCE:
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let propertiesCount = propertiesArray.count
        tableView.backgroundView = propertiesCount == 0 ? label : nil
        return propertiesCount
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        let property = propertiesArray[indexPath.row]
        cell.prepareCell(with: property)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "listSegue", sender: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "listSegue" {
            
            guard let destinationVC = segue.destination as? PropertyListTableViewController else { return }
            if let indexPath = tableView.indexPathForSelectedRow?.row {
                destinationVC.selectedProperty = propertiesArray[indexPath]
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete{
            guard let property = fetchedResultsController.fetchedObjects?[indexPath.row] else {return}
            context.delete(property)
            propertiesArray.remove(at: indexPath.row)
            saveContext()
            tableView.deleteRows(at: [indexPath], with: .fade)
        }    
    }
    
    
    // MARK: - FUNCTIONS
    
    func loadProperties() {
        
        let fetchRequest: NSFetchRequest<Property> = Property.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "streetAddress", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultsController.delegate = self as? NSFetchedResultsControllerDelegate
        
        do {
        try fetchedResultsController.performFetch()
            propertiesArray = fetchedResultsController.fetchedObjects!
        } catch {
            print(error.localizedDescription)
        }
        
        tableView.reloadData()
    }
    
    func loadLayout(){
        super.viewDidLoad()
        label.text = "No properties registered yet"
        label.textAlignment = .center
        addNewPropertyButton.layer.cornerRadius = addNewPropertyButton.frame.size.height/2
        viewButton.dropShadow()
    }
}

