//
//  RentalViewController.swift
//  Real Estate Calculator
//
//  Created by Alex Mendes on 4/25/19.
//  Copyright © 2019 Alex Mendes. All rights reserved.
//

import UIKit

class RentalViewController: UIViewController {

    var property: Property?
    var amt: Int = 0
    
    //LABEL RESULTS VIEW:
    
    @IBOutlet weak var propertyLB: UILabel!
    @IBOutlet weak var capRateLB: UILabel!
    @IBOutlet weak var incomeLB: UILabel!
    @IBOutlet weak var expensesLB: UILabel!
    @IBOutlet weak var cashFlowLB: UILabel!
    
    
    //TEXTFIELDS:
    @IBOutlet weak var purchasedPriceTF: UITextField!
    @IBOutlet weak var annualTaxesTF: UITextField!
    @IBOutlet weak var annualinsuranceTF: UITextField!
    @IBOutlet weak var waterSewerTF: UITextField!
    @IBOutlet weak var monthlyExpensesTF: UITextField!
    @IBOutlet weak var vacancyRate: UITextField!
    @IBOutlet weak var monthlyRentTF: UITextField!
    
    //UI ELEMENTS:
    @IBOutlet weak var calculateButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var resultView: UIView!
    
    
    
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
    }
    
    func uploadLayout() {
        navigationItem.title = "Rental"
        propertyLB.text = property?.streetAddress
        if property == nil {propertyLB.isHidden = true; extendedLayoutIncludesOpaqueBars = true}
        resultView.layer.masksToBounds = true
        resultView.layer.cornerRadius = 12
        resultView.setGradientBackgroundColor(colorOne: Colors.green, colorTwo: Colors.darkGreen)
        
        calculateButton.layer.cornerRadius = calculateButton.frame.size.height/2
    }
    
    func fillTextFields(){
        if property != nil {
            
            purchasedPriceTF.text = property?.purchasedPrice.stringConversion()
            annualTaxesTF.text = property?.taxes.stringConversion()
            annualinsuranceTF.text = property?.insurance.stringConversion()
            waterSewerTF.text = property?.waterSewer.stringConversion()
            monthlyExpensesTF.text = property?.monthlyExpenses.stringConversion()
            
            
        }
    }
    
    func calculate() {
        guard let purchasedPrice = purchasedPriceTF.text?.floatConversion() else {return}
        guard let propertyTaxes = annualTaxesTF.text?.floatConversion() else {return}
        guard let insurance = annualinsuranceTF.text?.floatConversion() else {return}
        guard let waterSewer = waterSewerTF.text?.floatConversion() else {return}
        guard let monthlyExpenses = monthlyExpensesTF.text?.floatConversion() else {return}
        guard let vacancyRate = vacancyRate.text?.floatConversion() else {return}
        guard let monthlyRent = monthlyRentTF.text?.floatConversion() else {return}
        
        
        let results = Calculators.rentalCalculate(purchasedPrice: purchasedPrice, propertyTaxes: propertyTaxes, insurance: insurance, waterSewer: waterSewer, monthlyExpenses: monthlyExpenses, vacancyRate: vacancyRate, monthlyRent: monthlyRent)
        
        capRateLB.text = results.capRate
        incomeLB.text = results.income
        expensesLB.text = results.expenses
        cashFlowLB.text = results.annualCashFlow
        
        
        scrollView.setContentOffset(CGPoint(x: 0.0, y: 0.0), animated: true)
    }
    
    func updateAmount() -> String? {
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        let amount = Float(amt/100) + Float(amt % 100) / 100
        
        return formatter.string(from: NSNumber(value: amount)) ?? ""
    }    
}


extension RentalViewController: UITextFieldDelegate {
    
    func delegateTextField() {
        purchasedPriceTF.delegate = self
        annualTaxesTF.delegate = self
        annualinsuranceTF.delegate = self
        waterSewerTF.delegate = self
        monthlyExpensesTF.delegate = self
        vacancyRate.delegate = self
        monthlyRentTF.delegate = self
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        
        if textField == annualTaxesTF || textField == vacancyRate {
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
