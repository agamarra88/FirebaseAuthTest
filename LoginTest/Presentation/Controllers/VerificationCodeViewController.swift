//
//  VerificationCodeViewController.swift
//  LoginTest
//
//  Created by Arturo Gamarra on 4/4/19.
//  Copyright © 2019 Intercorp. All rights reserved.
//

import UIKit
import FirebaseAuth
import IQKeyboardManagerSwift

class VerificationCodeViewController: UIViewController {
    
    // MARK: - Properties
    @IBOutlet var textFields: [ABSNumericTextField]!
    @IBOutlet weak var loadingActivityIndicatorView: UIActivityIndicatorView!
    var verificationId:String = ""

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        loadingActivityIndicatorView.isHidden = true
        let _ = textFields.first?.becomeFirstResponder()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        IQKeyboardManager.shared.enableAutoToolbar = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        IQKeyboardManager.shared.enableAutoToolbar = true
    }
    
    // MARK: - Instance methods
    private func valitateCode() {
        var code = ""
        for textField in textFields {
            code += textField.text!
        }
        
        loadingActivityIndicatorView.isHidden = false
        loadingActivityIndicatorView.startAnimating()
        let credential = PhoneAuthProvider.provider().credential(withVerificationID: verificationId, verificationCode: code)
        Auth.auth().signInAndRetrieveData(with: credential) { (authResult, error) in
            self.loadingActivityIndicatorView.stopAnimating()
            if let anError = error {
                self.showErrorView(withMessage: anError.localizedDescription)
                for textfield in self.textFields {
                    textfield.text = ""
                }
                return
            }
            guard let remoteUser = authResult?.user else {
                self.showErrorView(withMessage: "Credenciales de usuario inválidas. Intente nuevamente")
                for textfield in self.textFields {
                    textfield.text = ""
                }
                return
            }
            
            let user = User()
            user.id = remoteUser.uid
            user.phone = remoteUser.phoneNumber!
            
            let registerVC = RegisterViewController.intanceFromStoryboard()
            registerVC.user = user
            self.navigationController?.pushViewController(registerVC, animated: true)
        }
    }
    
    // MARK: - Class methods
    class func intanceFromStoryboard() -> VerificationCodeViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc = storyboard.instantiateViewController(withIdentifier: String(describing: self))
        return vc as! VerificationCodeViewController
    }

    // MARK: - Actions
    @IBAction func textFieldChanged(_ sender: ABSNumericTextField) {
        if var index = textFields.firstIndex(of: sender),
            let text = sender.text {
            
            index += text.count == 0 ? -1 : 1
            if index >= 0 && index < 6 {
                sender.isEnabled = false
                textFields[index].isEnabled = true
                let _ = textFields[index].becomeFirstResponder()
                
            } else if index == 6 {
                sender.isEnabled = false
                view.endEditing(true)
                valitateCode()
            }
            
        }
    }
}
