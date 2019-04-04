//
//  ABSDatePickerTextField.swift
//  Abstract
//
//  Created by Arturo Gamarra on 8/28/16.
//  Copyright © 2016 Abstract. All rights reserved.
//

import UIKit

enum UIDatePickerTextFieldMode:Int {
    case date
    case dateAndTime
    case countDownTimer
    case time
    
    var datePickerMode:UIDatePicker.Mode {
        switch self {
        case .countDownTimer:
            return .countDownTimer
        case .dateAndTime:
            return .dateAndTime
        case .date:
            return .date
        case .time:
            return .time
        }
    }
}

class ABSDatePickerTextField: ABSValidateTextField {

    // MARK: - Properties
    fileprivate var datePicker:UIDatePicker?
    
    var pickerMode:UIDatePickerTextFieldMode = .dateAndTime {
        didSet {
            setupDatePickerForMode(pickerMode)
            text = textFromDate(date, withMode: pickerMode)
        }
    }
    var date:Date? {
        didSet {
            datePicker?.date = date != nil ? date! : Date()
            text = textFromDate(date, withMode: pickerMode)
            sendActions(for: .editingChanged)
        }
    }
    var minimumDate:Date? {
        didSet {
            datePicker?.minimumDate = minimumDate
        }
    }
    var maximumDate:Date? {
        didSet {
            datePicker?.maximumDate = maximumDate
        }
    }
    var startDate:Date?
    
    // MARK: - Lifecycle
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupDatePickerTextField()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupDatePickerTextField()
    }
    
    // MARK: - Private
    fileprivate func setupDatePickerTextField() {
        clearButtonMode = .never
        setupDatePickerForMode(pickerMode)
        addTarget(self, action:#selector(textFieldEditingDidBegin(_:)), for:.editingDidBegin)
    }
    
    fileprivate func setupDatePickerForMode(_ mode:UIDatePickerTextFieldMode) {
        datePicker = UIDatePicker()
        datePicker?.datePickerMode = mode.datePickerMode
        datePicker?.addTarget(self, action:#selector(datePickerValueChanged(_:)), for: .valueChanged)
        datePicker?.date = date != nil ? date! : Date()
        datePicker?.minimumDate = minimumDate
        datePicker?.maximumDate = maximumDate
        inputView = datePicker
    }
    
    fileprivate func textFromDate(_ date:Date?, withMode mode:UIDatePickerTextFieldMode) -> String {
        guard let aDate = date else {
            return ""
        }
        switch (mode) {
        case .time:
            return DateFormatter.shared.string(fromDate: aDate, withFormat: "hh:mm a")
        case .date:
            return DateFormatter.shared.string(fromDate: aDate, withFormat: "dd/MM/yyyy")
        case .dateAndTime:
            return DateFormatter.shared.string(fromDate: aDate, withFormat: "dd/MM/yyyy HH:mm:ss")
        case .countDownTimer:
            return DateFormatter.shared.string(fromDate: aDate, withFormat: "HH:mm")
        }
    }
    
    // MARK: - UITextInput
    override func caretRect(for position: UITextPosition) -> CGRect {
        return CGRect.zero
    }
    
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        return false
    }
    
    // MARK: - Action
    @IBAction func datePickerValueChanged(_ datePicker:UIDatePicker) {
        date = datePicker.date
    }

    @IBAction func textFieldEditingDidBegin(_ textField:UITextField) {
        if let _ = date {
            return
        }
        OperationQueue.main.addOperation {
            if let startDate = self.startDate {
                self.date = startDate
            } else {
                self.date = Date()
            }
        }
    }
}
