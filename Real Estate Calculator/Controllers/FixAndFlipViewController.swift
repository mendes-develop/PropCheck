//
//  FixAndFlipViewController.swift
//  Real Estate Calculator
//
//  Created by Alex Mendes on 4/25/19.
//  Copyright © 2019 Alex Mendes. All rights reserved.
//

import UIKit

class FixAndFlipViewController: UIViewController {

    var property: Property?
    var amt: Int = 0
    
    //LABEL RESULTS VIEW:
    @IBOutlet weak var propertyLB: UILabel!
    @IBOutlet weak var roiLB: UILabel!
    @IBOutlet weak var salesPriceLB: UILabel!
    @IBOutlet weak var totalinvestedLB: UILabel!
    @IBOutlet weak var netProfitLB: UILabel!
    
    //TEXTFIELDS:
    @IBOutlet weak var purchasedPriceTF: UITextField!
    @IBOutlet weak var repairsTF: UITextField!
    @IBOutlet weak var arvTF: UITextField!
    @IBOutlet weak var closingCostsTF: UITextField!
    @IBOutlet weak var taxesTF: UITextField!
    @IBOutlet weak var insuranceTF: UITextField!
    @IBOutlet weak var expensesTF: UITextField!
    @IBOutlet weak var holdingTF: UITextField!
    
    //UI ELEMENTS:
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var resultView: UIView!
    @IBOutlet weak var calculateButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegateTextField()
        fillTextFields()
        hideKeyboard()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        uploadLayout()
    }
    

    @IBAction func calculateButton(_ sender: UIButton) {
        
        calculate()
        scrollView.setContentOffset(CGPoint(x: 0.0, y: 0.0), animated: true)
    }
    
    func uploadLayout() {
        navigationItem.title = "Fix and Flip"
        propertyLB.text = property?.streetAddress
        if property == nil {propertyLB.isHidden = true; extendedLayoutIncludesOpaqueBars = true}
        resultView.layer.masksToBounds = true
        resultView.layer.cornerRadius = 12
        resultView.setGradientBackgroundColor(colorOne: Colors.goldYellow, colorTwo: Colors.darkYellow)
        calculateButton.layer.cornerRadius = calculateButton.frame.size.height/2
    }
    
    func fillTextFields() {
        if property != nil {
            
            purchasedPriceTF.text = property?.purchasedPrice.stringConversion()
            repairsTF.text = property?.repairs.stringConversion()
            taxesTF.text = property?.taxes.stringConversion()
            expensesTF.text = property?.monthlyExpenses.stringConversion()
            insuranceTF.text = property?.insurance.stringConversion()
            arvTF.text = property?.afterRepair.stringConversion()
        }
    }
    
    func calculate() {
        let purchasedPrice = purchasedPriceTF.text?.floatConversion() ?? 0.0
        let repairs = repairsTF.text?.floatConversion() ?? 0.0
        let arv = arvTF.text?.floatConversion() ?? 0.0
        let closingCosts = Float(closingCostsTF.text!) ?? 0.0
        let propertyTaxes = taxesTF.text?.floatConversion() ?? 0.0
        let expenses = expensesTF.text?.floatConversion() ?? 0.0
        let insurance = insuranceTF.text?.floatConversion() ?? 0.0
        let holdingLength = Float(holdingTF.text!) ?? 12.0
    
        let results = Calculators.fixAndFlipCalculate(purchasedPrice: purchasedPrice, repairs: repairs, arv: arv, percentageClosingCosts: closingCosts, propertyTaxes: propertyTaxes, insurance: insurance, monthlyExpenses: expenses, holdingLength: holdingLength)
    
        roiLB.text = results.roi
        salesPriceLB.text = results.salesPrice
        totalinvestedLB.text = results.investment
        netProfitLB.text = results.profit
    }
    
    
    func updateAmount() -> String? {
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        let amount = Float(amt/100) + Float(amt % 100) / 100
        return formatter.string(from: NSNumber(value: amount)) ?? ""
    }
}




extension FixAndFlipViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func delegateTextField() {
        purchasedPriceTF.delegate = self
        repairsTF.delegate = self
        arvTF.delegate = self
        closingCostsTF.delegate = self
        taxesTF.delegate = self
        insuranceTF.delegate = self
        expensesTF.delegate = self
        holdingTF.delegate = self
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField == closingCostsTF || textField == holdingTF {
            return true
            
        } else {
            
            if let digit = Int(string) {
                amt = amt * 10 + digit
                textField.text = updateAmount()
            }
            if string == "" {
                amt = amt/10
                textField.text = amt == 0 ? "" : updateAmount()
            }
        }
            return false
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        amt = 0
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        calculate()
    }
    
}
