//
//  UserManager.swift
//  Restaurante
//
//  Created by Arturo Gamarra on 3/24/19.
//  Copyright © 2019 Academia Moviles. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase

class UserManager {
    
    // MARK: - Singleton
    static let shared = UserManager()
    
    // MARK: - Properties
    var currentUser:User?
    
    // MARK: - Lifecycle
    init() {
        currentUser = retrieveUserSession()
    }
    
    // MARK: - Methods
    func register(user:User,
                  success: @escaping (User) -> Void,
                  failure: @escaping (Error) -> Void) {

        let ref = Database.database().reference()
        let userRef = ref.child("users")
        let newUser = userRef.child(user.id)
        newUser.setValue(user.json) { [unowned self] (error, dbRef) in
            if let anError = error {
                failure(anError)
                return
            }
            
            self.currentUser = user
            self.save(user: user)
            success(user)
        }
    }

    func logout() {
        UserDefaults.standard.removeObject(forKey: Constants.userKey)
        currentUser = nil
        
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    
    private func save(user:User) {
        do {
            let userData = try NSKeyedArchiver.archivedData(withRootObject: user,
                                                            requiringSecureCoding: false)
            UserDefaults.standard.setValue(userData, forKey: Constants.userKey)
        }
        catch(let ex) {
            print(ex)
        }
    }
    
    private func retrieveUserSession() -> User? {
        guard let userData = UserDefaults.standard.data(forKey: Constants.userKey),
            let user = NSKeyedUnarchiver.unarchiveObject(with: userData) as? User else {
            return nil
        }
        return user
    }
    
}
