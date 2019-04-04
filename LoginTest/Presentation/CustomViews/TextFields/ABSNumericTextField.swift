//
//  NumericTextField.swift
//  Abstract
//
//  Created by Arturo Gamarra on 6/23/15.
//  Copyright © 2016 Abstract. All rights reserved.
//

import UIKit

class ABSNumericTextField: ABSValidateTextField {
    
    // MARK: - View Life Cycle
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.keyboardType = UIKeyboardType.numberPad
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.keyboardType = UIKeyboardType.numberPad
    }
    
    // MARK: - Override
    override func replaceRegex() -> NSRegularExpression? {
        do {
            return try NSRegularExpression(pattern:"[^0-9]", options:.caseInsensitive)
        } catch _ {
            return nil
        }
    }
}
