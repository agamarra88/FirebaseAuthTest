//
//  DropDownTextField.swift
//  Abstract
//
//  Created by Arturo Gamarra on 4/18/16.
//  Copyright © 2016 Abstract. All rights reserved.
//

import UIKit

class ABSDropDownTextField: ABSValidateTextField, UIPickerViewDataSource, UIPickerViewDelegate {
    
    // MARK: - Properties
    var pickerView:UIPickerView!
    var selectedValue:DropDownable? {
        didSet {
            if oldValue?.description != self.selectedValue?.description {
                if let selectedImage = selectedValue?.image {
                    icon = selectedImage
                }
                text = self.selectedValue?.description
                sendActions(for: .editingChanged)
            }
        }
    }
    var elements:[DropDownable] = [] {
        didSet {
            self.pickerView.reloadAllComponents()
        }
    }

    // MARK: - Lifecycle
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupPickerView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupPickerView()
    }
    
    // MARK: - Private
    func setupPickerView() {
        self.pickerView = UIPickerView()
        self.pickerView.dataSource = self
        self.pickerView.delegate = self
        self.inputView = self.pickerView
        self.clearButtonMode = .never
        if (self.placeholder == nil || self.placeholder == "") {
            self.placeholder = NSLocalizedString("SELECT", comment: "Select")
        }
        self.addTarget(self, action:#selector(self.dropDownTextFieldDidBeginEditing(_:)), for:.editingDidBegin)
    }
    
    // MARK: - Public
    func clearSelection() {
        self.selectedValue = nil
        self.text = ""
    }

    // MARK: - Actions
    @IBAction func dropDownTextFieldDidBeginEditing(_ sender:UITextField) {
        var index = NSNotFound
        for i in 0..<self.elements.count {
            if (self.elements[i].description == selectedValue?.description) {
                index = i
                break
            }
        }
        index = index != NSNotFound ? index : 0
        OperationQueue.main.addOperation {
            self.selectedValue = index == 0 ? self.elements.first : self.elements[index]
            self.pickerView.selectRow(index, inComponent: 0, animated: false)
        }
    }
    
    // MARK: - UITextField
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 8, dy: 0)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 8, dy: 0)
    }
    
    // MARK: - UITextInput
    override func caretRect(for position: UITextPosition) -> CGRect {
        return CGRect.zero
    }
    
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        return false
    }
    
    // MARK: - UIResponder
    override func becomeFirstResponder() -> Bool {
        self.alpha = 0.5
        return super.becomeFirstResponder()
    }

    override func resignFirstResponder() -> Bool {
        self.alpha = 1.0
        return super.resignFirstResponder()
    }
    
    // MARK: - UIPickerViewDataSource
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
   
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return elements.count
    }
    
    // MARK: - UIPickerViewDelegate
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return elements[row].description
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedValue = row == 0 ? elements.first :elements[row]
    }
    
}
