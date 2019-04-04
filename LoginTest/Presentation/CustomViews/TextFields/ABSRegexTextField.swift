//
//  ABSRegexTextField.swift
//  Abstract
//
//  Created by Arturo Gamarra on 8/28/16.
//  Copyright © 2016 Abstract. All rights reserved.
//

import UIKit

class ABSRegexTextField: ABSValidateTextField {

    // MARK: - Properties
    @IBInspectable var allowableCharactersRegex:String = ""

    // MARK: - Override
    override func replaceRegex() -> NSRegularExpression? {
        do {
            let regex = String(format: "[^%@]", self.allowableCharactersRegex)
            return try NSRegularExpression(pattern:regex, options:.caseInsensitive)
        } catch _ {
            return nil
        }
    }
}
