//
//  ValidateTextField.swift
//  Abstract
//
//  Created by Arturo Gamarra on 6/24/15.
//  Copyright © 2016 Abstract. All rights reserved.
//

import UIKit

@IBDesignable class ABSValidateTextField: UITextField {
    
    // MARK: - Properties
    private var enableBorderStyle:UITextField.BorderStyle!
    private var enableColor:UIColor!
    private var lineView : UIView!
    
    @IBInspectable var cleanIfDisabled:Bool = true
    @IBInspectable var disableTrimText:Bool = false
    @IBInspectable var maxNumberOfCharacters:Int = Int.max
    @IBInspectable var iconLocationRight:Bool = false {
        didSet {
            setupIcon(withImage: icon)
        }
    }
    @IBInspectable var iconTopPadding:CGFloat = 0 {
        didSet {
            setupIcon(withImage: icon)
        }
    }
    @IBInspectable var iconRightPadding:CGFloat = 0 {
        didSet {
            setupIcon(withImage: icon)
        }
    }
    @IBInspectable var iconBottomPadding:CGFloat = 0 {
        didSet {
            setupIcon(withImage: icon)
        }
    }
    @IBInspectable var iconLeftPadding:CGFloat = 0 {
        didSet {
            setupIcon(withImage: icon)
        }
    }
    @IBInspectable var icon:UIImage? {
        didSet {
            setupIcon(withImage: icon)
        }
    }
    @IBInspectable var placeHolderColor: UIColor = UIColor.lightGray {
        didSet {
            setupPlaceHolder(withColor: placeHolderColor)
        }
    }
    
    override var isEnabled: Bool {
        didSet {
            if isEnabled {
                borderStyle = enableBorderStyle
                backgroundColor = enableColor
            } else {
                if cleanIfDisabled {
                    borderStyle = .none
                    backgroundColor = .clear
                }
            }
        }
    }
    override var text: String? {
        get {
            if (!disableTrimText && !isSecureTextEntry) {
                return super.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
            }
            return super.text
        }
        set {
            super.text = newValue
        }
    }
    
    var valid:Bool = true {
        didSet {
            if (!valid) {
                layoutIfNeeded()
                layer.borderWidth = 1.0
                layer.cornerRadius = 5.0
                layer.borderColor = UIColor.red.cgColor
            } else {
                layoutIfNeeded()
                layer.borderWidth = 0
                layer.cornerRadius = 0
                layer.borderColor = UIColor.clear.cgColor
            }
        }
    }
    
    // MARK: - Lifecycle
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupValidateTextField()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupValidateTextField()
    }
    
    // MARK: - Private
    private func setupValidateTextField() {
        clipsToBounds = true
        enableColor = backgroundColor
        enableBorderStyle = borderStyle
        setupPlaceHolder(withColor: placeHolderColor)
        addTarget(self, action:#selector(textFieldEditingChanged(_:)), for:.editingChanged)
    }
    
    private func setupIcon(withImage icon:UIImage?) {
        guard let image = icon else {
            setIconView(nil)
            return
        }
        let leftPadding = iconLeftPadding + (!iconLocationRight ? 4: 0)
        let height = bounds.height - 6
        let width = image.size.width * height / image.size.height
        let view = UIView(frame: CGRect(x: 0, y: 0, width: width+4, height: bounds.height))
        let imageView = UIImageView(frame: CGRect(x: leftPadding, y: iconTopPadding+3, width: width-leftPadding-iconRightPadding, height: height-iconTopPadding-iconBottomPadding))
        imageView.image = image
        view.addSubview(imageView)
        
        setIconView(view)
    }
    
    private func setupPlaceHolder(withColor color: UIColor) {
        if let text = placeholder {
            attributedPlaceholder = NSAttributedString(string: text, attributes:[NSAttributedString.Key.foregroundColor: color])
        }
    }
    
    private func setIconView(_ view:UIView?) {
        if (iconLocationRight) {
            leftView = nil
            rightView = view
            rightViewMode = view != nil ? .always : .never
        } else {
            leftView = view
            rightView = nil
            leftViewMode = view != nil ? .always : .never
        }
    }
    
    // MARK: Override
    override func becomeFirstResponder() -> Bool {
        setupPlaceHolder(withColor: placeHolderColor)
        return super.becomeFirstResponder()
    }
    
    override func resignFirstResponder() -> Bool {
        setupPlaceHolder(withColor: placeHolderColor)
        return super.resignFirstResponder()
    }
    
    override func deleteBackward() {
        super.deleteBackward()
        if text?.count == 0 {
            sendActions(for: .editingChanged)
        }
    }
    
    // MARK: - Public
    func replaceRegex() -> NSRegularExpression? {
        return nil
    }
    
    // MARK: - Actions
    @IBAction func textFieldEditingChanged(_ sender:UITextField) {
        undoManager?.removeAllActions()
        valid = true
        if let regex = replaceRegex() {
            var cursorPosition = offset(from: beginningOfDocument, to: selectedTextRange!.start)
            let length = super.text!.count
            super.text = regex.stringByReplacingMatches(in: super.text!, options:.reportProgress, range:NSMakeRange(0, length), withTemplate: "")
            let countCursorMove = super.text!.count - length
            
            //Set cursor position
            cursorPosition = cursorPosition + countCursorMove
            if let targetPosition = position(from: beginningOfDocument, offset: cursorPosition) {
                selectedTextRange = textRange(from: targetPosition, to: targetPosition)
            }
        }
        
        if (maxNumberOfCharacters < super.text!.count && maxNumberOfCharacters != 0) {
            let index = super.text!.index(super.text!.startIndex, offsetBy: maxNumberOfCharacters)
            super.text = String(super.text![index...])
        }
    }
}
