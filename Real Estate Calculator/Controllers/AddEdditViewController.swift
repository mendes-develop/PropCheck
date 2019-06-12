//
//  AddEdditViewController.swift
//  Real Estate Calculator
//
//  Created by Alex Mendes on 4/25/19.
//  Copyright © 2019 Alex Mendes. All rights reserved.
//

import UIKit
import Foundation

class AddEdditViewController: UIViewController {
    
    //DECLARED PROPERTIES
    var property: Property?
    var amt: Int = 0
    
    //TEXTFIELDS
    @IBOutlet weak var streetAddressTF: UITextField!
    @IBOutlet weak var cityAddressTF: UITextField!
    @IBOutlet weak var purchasedPriceTF: UITextField!
    @IBOutlet weak var repairsTF: UITextField!
    @IBOutlet weak var arvTF: UITextField!
    @IBOutlet weak var taxesTF: UITextField!
    @IBOutlet weak var insuranceTF: UITextField!
    @IBOutlet weak var waterSewerTF: UITextField!
    @IBOutlet weak var monthlyExpensesTF: UITextField!
    
    //UIVIEWS AND BUTTONS
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var addPhotoButton: UIButton!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = property?.streetAddress ?? "Add New Property"
        delegateTextField()
        hideKeyboard()
        fillTextFields()
    }
    
    @IBAction func addPhotoButton(_ sender: UIButton) {
        presentAlert()
    }
    
    
    @IBAction func saveButton(_ sender: Any) {
        saveProperty()
    }
    
        func fillTextFields() {

            if property != nil {
                streetAddressTF.text = property?.streetAddress
                cityAddressTF.text = property?.cityState
                purchasedPriceTF.text = property?.purchasedPrice.stringConversion()
                arvTF.text = property?.afterRepair.stringConversion()
                taxesTF.text = property?.taxes.stringConversion()
                insuranceTF.text = property?.insurance.stringConversion()
                waterSewerTF.text = property?.waterSewer.stringConversion()
                monthlyExpensesTF.text = property?.monthlyExpenses.stringConversion()
                photoImageView.image = property?.photo as? UIImage
                if let photo = property?.photo as? UIImage {
                    photoImageView.image = photo
                    addPhotoButton.setTitle(nil, for: .normal)
                }
            }
        }
        
        
    func updateAmount() -> String? {
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        let amount = Float(amt/100) + Float(amt % 100) / 100
        return formatter.string(from: NSNumber(value: amount)) ?? ""
    }
    
    func nilTextField(_ field: String ) -> Void {
        let alert = UIAlertController(title: "Empty Text Field ", message: "Please, Insert \(field).", preferredStyle: .alert)
        let cancelationButton = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alert.addAction(cancelationButton)
        return present(alert, animated: true, completion: nil)
    }
    
    func saveProperty() {
        if property == nil {
            property = Property(context: context)
        }
        
        if streetAddressTF.text != "" { property?.streetAddress =  streetAddressTF.text } else { nilTextField("Street Address")}
        if  cityAddressTF.text != "" { property?.cityState = cityAddressTF.text } else { nilTextField("City and State")}
        if purchasedPriceTF.text != "" { property?.purchasedPrice = (purchasedPriceTF.text?.floatConversion())! } else { nilTextField("Purchase Price")}
        if arvTF.text != "" { property?.afterRepair = (arvTF.text?.floatConversion())! } else {nilTextField("After Repair Value")}
        
        if let repairs = repairsTF.text?.floatConversion() { property?.repairs = repairs }
        if let taxes = taxesTF.text?.floatConversion() { property?.taxes = taxes }
        if let insurance = insuranceTF.text?.floatConversion() {  property?.insurance = insurance}
        if let waterSewer =  waterSewerTF.text?.floatConversion() { property?.waterSewer = waterSewer }
        if let monthlyExpenses = monthlyExpensesTF.text?.floatConversion() { property?.monthlyExpenses = monthlyExpenses }
        
        if property?.photo == nil {
            property?.photo = UIImage(named: "defaultHome")
            } else {
            property?.photo = photoImageView.image
            }
        

        saveContext()
        navigationController?.popViewController(animated: true)
    }
    
    func selectPicture(sourceType: UIImagePickerController.SourceType) {
        
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = sourceType
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    func presentAlert() {
        let alert = UIAlertController(title: "Select a Property Image", message: "Where would you like to choose your image from?", preferredStyle: .actionSheet)
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let cameraAction = UIAlertAction(title: "Camera", style: .default) { (action) in
                self.selectPicture(sourceType: .camera)
            }
            alert.addAction(cameraAction)
        }
        
        let libraryAction = UIAlertAction(title: "Library", style: .default) { (action) in
            self.selectPicture(sourceType: .photoLibrary)
        }
        alert.addAction(libraryAction)
        
        let photosAction = UIAlertAction(title: "Saved Photos", style: .default) { (action) in
            self.selectPicture(sourceType: .savedPhotosAlbum)
        }
        alert.addAction(photosAction)
        
        let cancelationButton = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(cancelationButton)
        
        present(alert, animated: true, completion: nil)

    }
}

extension AddEdditViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        photoImageView.image = image
        addPhotoButton.setTitle(nil, for: .normal)
        dismiss(animated: true, completion: nil)
    }
}

extension AddEdditViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
    
    func delegateTextField() {
        streetAddressTF.delegate = self
        cityAddressTF.delegate = self
        purchasedPriceTF.delegate = self
        repairsTF.delegate = self
        arvTF.delegate = self
        taxesTF.delegate = self
        insuranceTF.delegate = self
        waterSewerTF.delegate = self
        monthlyExpensesTF.delegate = self
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        
        if textField == streetAddressTF || textField == cityAddressTF {
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
    
    
    
}

