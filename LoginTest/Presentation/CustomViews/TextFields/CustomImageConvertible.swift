//
//  CustomImageConvertible.swift
//  Abstract
//
//  Created by Arturo Gamarra on 1/29/19.
//  Copyright © 2016 Abstract. All rights reserved.
//

import UIKit

public protocol CustomImageConvertible {
    
    var image:UIImage? { get }
    
}

extension String: CustomImageConvertible {
    
    public var image: UIImage? {
        return nil
    }
    
}
