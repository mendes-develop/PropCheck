//
//  ViewController+CoreData.swift
//  Real Estate Calculator
//
//  Created by Alex Mendes on 4/24/19.
//  Copyright © 2019 Alex Mendes. All rights reserved.
//

import UIKit
import CoreData


extension UIViewController {
    
    var context: NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
        
        
    }
    
    func saveContext() {
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
}
