//
//  Extension String.swift
//  Real Estate Calculator
//
//  Created by Alex Mendes on 4/25/19.
//  Copyright © 2019 Alex Mendes. All rights reserved.
//

import Foundation

extension String {
    
    func floatConversion() -> Float {
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        let number = formatter.number(from: self)
        let amount = number?.floatValue
        
        
        return amount ?? 0.00
    }
    
    func floatConversionPercent() -> Float {
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .percent
        let number = formatter.number(from: self)
        let amount = number?.floatValue
        
        return amount ?? 0.00
    }
    
    
    
    
    
}
