//
//  UIViewControllerAlertExtension.swift
//  Abstract
//
//  Created by agamarra on 12/16/15.
//  Copyright © 2015 Abstract. All rights reserved.
//

import UIKit

extension UIViewController {

    func showErrorView(withMessage message:String) {
        self.showAlertView(withTitle: NSLocalizedString("Error", comment: "Error"), withMessage: message)
    }
    
    func showAlertView(withMessage message:String) {
        self.showAlertView(withTitle: NSLocalizedString("Alert", comment: "Alerta"), withMessage: message)
    }
    
    func showAlertView(withTitle title:String, withMessage message:String) {
        self.showAlertView(withTitle: title, withMessage: message, withResponseBlock: nil)
    }
    
    func showAlertView(withTitle title:String, withMessage message:String, withResponseBlock responseBlock:(() -> Void)?) {
        let alertViewController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: NSLocalizedString("OK", comment: "OK"), style: .default) { (action:UIAlertAction) -> Void in
            if (responseBlock != nil) {
                responseBlock!()
            }
            alertViewController.dismiss(animated: true, completion: nil)
        }
        alertViewController.addAction(okAction)
        self.present(alertViewController, animated: true, completion: nil)
    }
    
    func showOkCancelAlertView(withTitle title:String, withMessage message:String, withResponseBlock responseBlock:@escaping (_ isOk:Bool) -> Void) {
        let okTitle = NSLocalizedString("OK", comment: "OK")
        self.showOkCancelAlertView(withTitle: title, withMessage: message, withOkTitle: okTitle, withResponseBlock: responseBlock)
    }
    
    func showOkCancelAlertView(withTitle title:String, withMessage message:String, withOkTitle okTitle:String, withResponseBlock responseBlock:@escaping (_ isOk:Bool) -> Void) {
        let alertViewController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: okTitle, style: .default) { (action:UIAlertAction) -> Void in
            responseBlock(true)
            alertViewController.dismiss(animated: true, completion: nil)
        }
        let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: "Cancel"), style: .default) { (action:UIAlertAction) -> Void in
            responseBlock(false)
            alertViewController.dismiss(animated: true, completion: nil)
        }
        alertViewController.addAction(okAction)
        alertViewController.addAction(cancelAction)
        self.present(alertViewController, animated: true, completion:nil)
    }
    
    
    
    func showActionSheet<T>(withTitle title:String,
                            message:String? = nil,
                            options:[T],
                            inView view:UIView? = nil,
                            response:@escaping (_ index:Int, _ selectedOption:T?) -> Void) where T:CustomStringConvertible {
        
        let alert = createActionSheetController(withTitle: title, message: message, options: options, response: response)
        
        let sourceView:UIView = view ?? self.view
        if UIDevice.current.userInterfaceIdiom == .pad {
            alert.modalPresentationStyle = .popover
            
            let popoverPresenter = alert.popoverPresentationController
            popoverPresenter?.sourceView = sourceView
            popoverPresenter?.sourceRect = sourceView.bounds
        }
        present(alert, animated: true, completion: nil)
    }
    
    private func createActionSheetController<T>(withTitle title:String,
                                                message:String?,
                                                options:[T],
                                                response:@escaping (_ index:Int, _ selectedOption:T?) -> Void) -> UIAlertController where T:CustomStringConvertible {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        
        for i in 0..<options.count {
            let option = options[i]
            let actionTitle = option.description
            let optionAction = UIAlertAction(title: actionTitle, style: .default) { [unowned alert] (_) in
                response(i, option)
                alert.dismiss(animated: true, completion: nil)
            }
            alert.addAction(optionAction)
        }
        
        // Create cancel action
        let cancelTitle = NSLocalizedString("Cancel", comment: "Cancel")
        let cancelAction = UIAlertAction(title: cancelTitle, style: .cancel) { [unowned alert] (_) in
            response(-1, nil)
            alert.dismiss(animated: true, completion: nil)
        }
        alert.addAction(cancelAction)
        
        return alert
    }
}

