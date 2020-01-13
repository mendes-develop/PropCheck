//
//  Calculators.swift
//  Real Estate Calculator
//
//  Created by Alex Mendes on 4/27/19.
//  Copyright © 2019 Alex Mendes. All rights reserved.
//

import Foundation


struct FixandFlipResult {
    var roi: String
    var salesPrice: String
    var investment: String
    var profit: String
}

struct RentalResult {
    var capRate: String
    var income: String
    var expenses: String
    var annualCashFlow: String
    
}

struct MortgageResult {
    
    var monthlyPayment: String
    var loanAmount: String
    var principalInterest: String
    var otherExpenses: String
    
}


class Calculators {
    
    static func fixAndFlipCalculate(purchasedPrice: Float, repairs: Float, arv: Float, percentageClosingCosts: Float, propertyTaxes: Float, insurance: Float, monthlyExpenses: Float,  holdingLength: Float) -> FixandFlipResult {
        
        var roiString: String = "--"
        var salesPriceString: String = "$0.00"
        var totalInvestedString:String = "$0.00"
        var profitString: String = "$0.00"
        
        if purchasedPrice > 0 && arv > 0 && holdingLength > 0  {
        
        let totalMonthlyExpenses = ((propertyTaxes + insurance) * (holdingLength/12)) + (monthlyExpenses * holdingLength)
            
        let closingCosts = (percentageClosingCosts/100) * arv
            
        let totalInvested = purchasedPrice + repairs + totalMonthlyExpenses + closingCosts
            totalInvestedString = totalInvested.stringConversion()
            
        let profit = arv - totalInvested
            profitString = profit.stringConversion()
            
        let roi = profit / totalInvested
            roiString = roi.stringConversionPercentage()
            
            salesPriceString = arv.stringConversion()
        
        }
            
        return FixandFlipResult(roi: roiString, salesPrice: salesPriceString, investment: totalInvestedString, profit: profitString)
    }



    
    static func rentalCalculate (purchasedPrice: Float, propertyTaxes: Float, insurance: Float,waterSewer: Float, monthlyExpenses: Float, vacancyRate: Float, monthlyRent: Float) -> RentalResult {
        
        var capRateString = "--"
        var annualIncomeString = "$0.00"
        var annualExpensesString = "$0.00"
        var annualCashFlowString = "$0.00"
        
        if purchasedPrice > 0 && monthlyRent > 0 {
        
        let annualIncome = monthlyRent * 12
            annualIncomeString = annualIncome.stringConversion()
            
        let annualExpenses = propertyTaxes + insurance + (monthlyExpenses * 12) + ((vacancyRate/100) * annualIncome)
            annualExpensesString = annualExpenses.stringConversion()
            
        let annualCashFlow = annualIncome - annualExpenses
            annualCashFlowString = annualCashFlow.stringConversion()
            
        let annualCapRate = annualCashFlow / purchasedPrice
            capRateString = annualCapRate.stringConversionPercentage()
        
        }
        return RentalResult(capRate: capRateString, income: annualIncomeString, expenses: annualExpensesString, annualCashFlow: annualCashFlowString)
    }



    
    
    static func calculateMortgage (purchasedPrice: Float, downPayment: Float, interestRate: Float, term: Float, taxes: Float, insurance: Float, monthlyHOA: Float) -> MortgageResult {
        
        var monthlyPaymentString = "--"
        var loanAmountString = "$0.00"
        var principalInterestString = "$0.00"
        var otherExpensesString = "$0.00"
        
        if purchasedPrice > 0.0 && interestRate > 0.0 && term > 0.0 {
            
        let months: Float = term * 12
        let monthlyRate: Float = (interestRate / 12) / 100
        let pow: Float = powf((1 + monthlyRate), months)
            
        let loanAmount = purchasedPrice - downPayment
            loanAmountString = loanAmount.stringConversion()
            
        let principalInterest = loanAmount * (monthlyRate * pow) / (pow - 1)
            principalInterestString = principalInterest.stringConversion()
         
        
        let monthlyExpenses = ((taxes + insurance)/12) + monthlyHOA
            otherExpensesString = monthlyExpenses.stringConversion()
            
        let monthlyPayment = principalInterest + monthlyExpenses
            monthlyPaymentString = monthlyPayment.stringConversion()
            
        
        }
        
        
        return MortgageResult(monthlyPayment: monthlyPaymentString, loanAmount: loanAmountString, principalInterest: principalInterestString, otherExpenses: otherExpensesString)
    }
    
    
    
    
}
