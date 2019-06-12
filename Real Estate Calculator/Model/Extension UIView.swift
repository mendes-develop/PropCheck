//
//  Extension UIView.swift
//  Real Estate Calculator
//
//  Created by Alex Mendes on 5/14/19.
//  Copyright © 2019 Alex Mendes. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    func setGradientBackgroundColor(colorOne: UIColor, colorTwo: UIColor){
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [colorOne.cgColor, colorTwo.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.startPoint = CGPoint(x: 1.0, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.0)
        
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func dropShadow(scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 1, height: 1)
        layer.shadowRadius = 1
        
        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        layer.shouldRasterize = false
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
    
    
}
