//
//  MortgageViewController.swift
//  Real Estate Calculator
//
//  Created by Alex Mendes on 4/25/19.
//  Copyright © 2019 Alex Mendes. All rights reserved.
//

import UIKit

class MortgageViewController: UIViewController {

    var property: Property?
    var amt: Int = 0
    
    //LABEL RESULTS:
    @IBOutlet weak var propertyLB: UILabel!
    @IBOutlet weak var monthlyPaymentLB: UILabel!
    @IBOutlet weak var loanAmountLB: UILabel!
    @IBOutlet weak var principalInterestLB: UILabel!
    @IBOutlet weak var otherExpensesLB: UILabel!
    
    //TEXT FIELDS:
    @IBOutlet weak var purchasedPriceTF: UITextField!
    @IBOutlet weak var downPaymentTF: UITextField!
    @IBOutlet weak var downPaymentPercTF: UITextField!
    @IBOutlet weak var interestRateTF: UITextField!
    @IBOutlet weak var termTF: UITextField!
    @IBOutlet weak var annualInsuranceTF: UITextField!
    @IBOutlet weak var annualTaxesTF: UITextField!
    @IBOutlet weak var monthlyHOATF: UITextField!
    
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
        
        updateLayout()
    }
    

    @IBAction func calculateButton(_ sender: UIButton) {
        calculate()
        scrollView.setContentOffset(CGPoint(x: 0.0, y: 0.0), animated: true)
    }
    
    func updateLayout() {
        navigationItem.title = "Mortgage"
        propertyLB.text = property?.streetAddress
        if property == nil {propertyLB.isHidden = true; extendedLayoutIncludesOpaqueBars = true}
        resultView.layer.masksToBounds = true
        resultView.layer.cornerRadius = 12
        resultView.setGradientBackgroundColor(colorOne: Colors.red, colorTwo: Colors.brightOrange)
        
        calculateButton.layer.cornerRadius = calculateButton.frame.size.height/2
    }
    
    func fillTextFields(){
        if property != nil {
            
            purchasedPriceTF.text = property?.purchasedPrice.stringConversion()
            annualTaxesTF.text = property?.taxes.stringConversion()
            annualInsuranceTF.text = property?.insurance.stringConversion()
            annualTaxesTF.text = property?.taxes.stringConversion()
            monthlyHOATF.text = property?.monthlyExpenses.stringConversion()
        }
    }
    
    func calculate() {
        let purchasedPrice = purchasedPriceTF.text?.floatConversion() ?? 0.0
        let downPayment = downPaymentTF.text?.floatConversion() ?? 0.0
        let interestRate = Float(interestRateTF.text!) ?? 0.0
        let term = Float(termTF.text!) ?? 0.0
        let annualTaxes = annualTaxesTF.text?.floatConversion() ?? 0.0
        let annualInsurance = annualInsuranceTF.text?.floatConversion() ?? 0.0
        let monhtlyHOA = monthlyHOATF.text?.floatConversion() ?? 0.0
        
        
        let results = Calculators.calculateMortgage(purchasedPrice: purchasedPrice, downPayment: downPayment, interestRate: interestRate, term: term, taxes: annualTaxes, insurance: annualInsurance, monthlyHOA: monhtlyHOA)
        
        monthlyPaymentLB.text = results.monthlyPayment
        loanAmountLB.text = results.loanAmount
        principalInterestLB.text = results.principalInterest
        otherExpensesLB.text = results.otherExpenses
    }
    
    
    func updateAmount() -> String? {
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        let amount = Float(amt/100) + Float(amt % 100) / 100
        
        return formatter.string(from: NSNumber(value: amount)) ?? ""
    }
    

}

extension MortgageViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
     
        textField.resignFirstResponder()
        return true
    }
    
    func delegateTextField() {
        purchasedPriceTF.delegate = self
        downPaymentPercTF.delegate = self
        downPaymentTF.delegate = self
        interestRateTF.delegate = self
        termTF.delegate = self
        annualInsuranceTF.delegate = self
        annualTaxesTF.delegate = self
        monthlyHOATF.delegate = self
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField == termTF || textField == interestRateTF || textField == downPaymentPercTF {
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
        
        if textField == purchasedPriceTF || textField == downPaymentTF {
            
            let purchasedPrice = purchasedPriceTF.text!.floatConversion()
            let downPayment = downPaymentTF.text!.floatConversion()
            let downPaymentePercentage = (purchasedPrice == 0) ? 0 : downPayment / purchasedPrice
            downPaymentPercTF.text = downPaymentePercentage.stringConversionPercentage()
            
        }

            if textField == purchasedPriceTF || textField == downPaymentPercTF {
                
                var downPaymentPercentage = (Float(downPaymentPercTF.text!)) ?? 0.0
                downPaymentPercentage /= 100.00
                let purchasedPrice = purchasedPriceTF.text!.floatConversion()
                let downPaymenteValue = downPaymentPercentage * purchasedPrice
                downPaymentTF.text = downPaymenteValue.stringConversion()
            }
        
//        switch textField {
//        case self.purchasedPriceTF:
//            self.downPaymentTF.becomeFirstResponder()
//            return
//        case self.downPaymentTF:
//            self.interestRateTF.becomeFirstResponder()
//            return
//        case self.downPaymentPercTF:
//            self.interestRateTF.becomeFirstResponder()
//            return
//        case self.interestRateTF:
//            self.termTF.becomeFirstResponder()
//            return
//        case self.termTF:
//            self.annualInsuranceTF.becomeFirstResponder()
//            return
//        case self.annualInsuranceTF:
//            self.annualTaxesTF.becomeFirstResponder()
//            return
//        case self.annualTaxesTF:
//            self.monthlyHOATF.becomeFirstResponder()
//            return
//        case self.monthlyHOATF:
//            return
//        default: break
//        }
        
        calculate()
        
        }
}
