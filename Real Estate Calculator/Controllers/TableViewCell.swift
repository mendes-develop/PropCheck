//
//  TableViewCell.swift
//  Real Estate Calculator
//
//  Created by Alex Mendes on 4/24/19.
//  Copyright © 2019 Alex Mendes. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    // Outlets:
    @IBOutlet weak var ivCellPhoto: UIImageView!
    @IBOutlet weak var streetAddressLB: UILabel!
    @IBOutlet weak var cityStateLB: UILabel!
    @IBOutlet weak var purchasedprceLB: UILabel!
    

    
    func prepareCell(with property: Property) {
        
        if let photo = property.photo as? UIImage {
            ivCellPhoto.image = photo
        } else {
            ivCellPhoto.image = UIImage(named: "defaultHome")
        }
        
        if  streetAddressLB.text != "" {
            streetAddressLB.text = property.streetAddress
        } else {
            streetAddressLB.text = "No Address" }
        
        if cityStateLB.text != "" {
            cityStateLB.text = property.cityState
        } else {
            cityStateLB.text = "No City Provide"
        }
        
        if purchasedprceLB.text != "" {
            purchasedprceLB.text = property.purchasedPrice.stringConversion()
        } else {
            purchasedprceLB.text = "Price not provided"
        }
        
    }

}
