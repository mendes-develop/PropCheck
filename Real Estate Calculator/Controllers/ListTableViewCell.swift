//
//  ListTableViewCell.swift
//  Real Estate Calculator
//
//  Created by Alex Mendes on 5/8/19.
//  Copyright © 2019 Alex Mendes. All rights reserved.
//

import UIKit

class ListTableViewCell: UITableViewCell {

    @IBOutlet weak var ivIcon: UIImageView!
    @IBOutlet weak var lbcell: UILabel!
    
    let listCells = ["Fix and Flip Calculator","Rental Calculator","Mortgage Calculator", "Update Property"]
    let imagesListCell = ["tools100","key100","bank100","condo100"]
    
    
    func prepareCell(with indexPath: IndexPath) {
        
        lbcell.text = listCells[indexPath.row]
        ivIcon.image = UIImage(named: imagesListCell[indexPath.row] )
        
        
    }

}
