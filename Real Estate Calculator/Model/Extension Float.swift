//
//  Extension Float.swift
//  Real Estate Calculator
//
//  Created by Alex Mendes on 4/25/19.
//  Copyright © 2019 Alex Mendes. All rights reserved.
//

import Foundation

extension Float {
    
    func stringConversion() -> String {
        let formatter = NumberFormatter()
        
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        formatter.numberStyle = .currency
        formatter.groupingSeparator = ","
        
        return formatter.string(for: self) ?? ""
    }
    
    func stringConversionPercentage() -> String {
        let formatter = NumberFormatter()
        
        formatter.maximumFractionDigits = 2
        formatter.numberStyle = .percent
        
        return formatter.string(for: self) ?? ""
    }
    
    
    
    
    
    
    
}
