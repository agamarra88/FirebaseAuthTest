//
//  RegisterViewController.swift
//  LoginTest
//
//  Created by Arturo Gamarra on 4/3/19.
//  Copyright © 2019 Intercorp. All rights reserved.
//

import UIKit

fileprivate extension Constants {
    
    static let showWelcomeSegueIdentifier = "WelcomeViewControllerModalSegue"
    
}

class RegisterViewController: UIViewController {
    
    // MARK: - Properties
    @IBOutlet weak var nameTextField: ABSLetterTextField!
    @IBOutlet weak var lastNameTextField: ABSLetterTextField!
    @IBOutlet weak var emailTextField: ABSLetterTextField!
    @IBOutlet weak var birthDateTextField: ABSDatePickerTextField!
    lazy var user:User = User()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        let today = Date.today
        birthDateTextField.pickerMode = .date
        birthDateTextField.startDate = today
        birthDateTextField.maximumDate = today
        birthDateTextField.minimumDate = today.date(byAddingMonths: -1080)
        navigationItem.hidesBackButton = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
    
    // MARK: - Class methods
    class func intanceFromStoryboard() -> RegisterViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc = storyboard.instantiateViewController(withIdentifier: String(describing: self))
        return vc as! RegisterViewController
    }

    @IBAction func registerButtonTapped(_ sender: Any) {
        view.endEditing(true)
        guard let name = nameTextField.text
            , let lastName = lastNameTextField.text
            , let email = emailTextField.text
            , let birthDate = birthDateTextField.date
            , !name.isEmpty && !lastName.isEmpty && !email.isEmpty else {
                let message = NSLocalizedString("register_invalid_form", comment: "El formulario no ha sido llenado en su totalidad. Por favor, complete el formulario")
                self.showErrorView(withMessage: message)
            return
        }
        user.name = name
        user.lastName = lastName
        user.email = email
        user.birthDate = birthDate
        
        
        UserManager.shared.register(user: user, success: { (_) in
            self.performSegue(withIdentifier: Constants.showWelcomeSegueIdentifier, sender: self)
            
        }) { (error) in
            self.showErrorView(withMessage: error.localizedDescription)
        }
        
    }
}
