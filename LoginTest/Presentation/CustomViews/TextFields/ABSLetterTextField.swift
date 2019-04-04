//
//  LetterTextField.swift
//  Abstract
//
//  Created by Arturo Gamarra on 6/24/15.
//  Copyright © 2016 Abstract. All rights reserved.
//

import UIKit

class ABSLetterTextField: ABSValidateTextField {

    // MARK: - View Life Cycle
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        if (self.keyboardType != .emailAddress) {
            self.keyboardType = .asciiCapable
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        if (self.keyboardType != .emailAddress) {
            self.keyboardType = .asciiCapable
        }
    }

    // MARK: - Override
    override func replaceRegex() -> NSRegularExpression? {
        if (self.keyboardType == .emailAddress) {
            do {
                return try NSRegularExpression(pattern:"[^A-Za-z1234567890@.\\_\\-]", options:.caseInsensitive)
            } catch _ {
                return nil
            };
        } else {
            do {
                return try NSRegularExpression(pattern:"[^A-Za-zñáéíóú\\s]", options:.caseInsensitive)
            } catch _ {
                return nil
            };
        }
    }
}
