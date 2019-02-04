//
//  AttributeViewController.swift
//  forms
//
//  Created by Макс on 21/01/2019.
//  Copyright © 2019 Макс. All rights reserved.
//

import UIKit

class AttributeViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var toolBarLabel: UINavigationItem!
    @IBOutlet weak var attributeCode: UITextField!
    @IBOutlet weak var attributeDisplayName: UITextField!
    @IBOutlet weak var attributeInternalCode: UITextField!
    @IBOutlet weak var attributeDescription: UITextView!
    private var internalCodePicker: UIPickerView?
    
    var currentTitle = ""
    var isAttributeChanged = false
    var currentAttribute: Group?
    let activityIndicator = UIActivityIndicatorView()

    override func viewDidLoad() {
        super.viewDidLoad()
        if toolBarLabel.title == "General Settings" {
            createPicker()
            createToolBar()
            attributeDescription.layer.borderWidth = 0.5
            attributeDescription.layer.borderColor = UIColor.init(red: 0.85, green: 0.85, blue: 0.85, alpha: 1.0).cgColor
            attributeDescription.layer.cornerRadius = 5.0
        }

    }
    
    func createPicker() {
        internalCodePicker = UIPickerView()
        internalCodePicker?.backgroundColor = .white
        internalCodePicker?.delegate =  self
        internalCodePicker?.dataSource = self
        internalCodePicker?.showsSelectionIndicator = true
        
        if let ac = internalCodePicker {
            print(ac)
        } else {
            print("bad")
        }
        attributeInternalCode.inputView = internalCodePicker
    }
    
    func createToolBar() {
        
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.dismissKeyboard))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        
        toolBar.setItems([spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        attributeInternalCode.inputAccessoryView = toolBar
        
    }
    
    
    @objc func dismissKeyboard () {
        view.endEditing(true)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return BASE_TYPES.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return BASE_TYPES[row].appName
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        attributeInternalCode.text = BASE_TYPES[row].appName
    }
    

    
}
