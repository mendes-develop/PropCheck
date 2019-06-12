//
//  ExtensionViewController.swift
//  Real Estate Calculator
//
//  Created by Alex Mendes on 4/28/19.
//  Copyright © 2019 Alex Mendes. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func hideKeyboard() {
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func dismissKeyboard(){
    view.endEditing(true)
    }
    
    
}
