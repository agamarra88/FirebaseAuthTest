//
//  ViewController.swift
//  LoginTest
//
//  Created by Arturo Gamarra on 4/3/19.
//  Copyright © 2019 Intercorp. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    // MARK: - Properties
    @IBOutlet weak var countryCodeLabel: UILabel!
    @IBOutlet weak var phoneTextField: UITextField!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func loginButtonTapped(_ sender: Any) {
        guard let phone = phoneTextField.text else {
            self.showErrorView(withMessage: "Indique el número telefónico")
            return
        }
        let completePhone = countryCodeLabel.text! + phone
        PhoneAuthProvider.provider().verifyPhoneNumber(completePhone, uiDelegate: nil) { (verificationID, error) in
            if let anError = error {
                self.showErrorView(withMessage: anError.localizedDescription)
                return
            }
        
            let verificationCodeVC = VerificationCodeViewController.intanceFromStoryboard()
            verificationCodeVC.verificationId = verificationID ?? ""
            self.navigationController?.pushViewController(verificationCodeVC, animated: true)
        }
    }
    
}

