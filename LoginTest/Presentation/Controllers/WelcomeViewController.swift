//
//  WelcomeViewController.swift
//  LoginTest
//
//  Created by Arturo Gamarra on 4/4/19.
//  Copyright © 2019 Intercorp. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    @IBOutlet weak var userLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let user = UserManager.shared.currentUser {
            userLabel.text = user.fullName
        }
    }

    @IBAction func logoutButtonTapped(_ sender: Any) {
        UserManager.shared.logout()
        if let vc = self.storyboard?.instantiateInitialViewController() {
            present(vc, animated: true, completion: nil)
        }
    }
}
