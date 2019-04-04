//
//  User.swift
//  Restaurante
//
//  Created by Arturo Gamarra on 3/24/19.
//  Copyright © 2019 Academia Moviles. All rights reserved.
//

import Foundation

class User: NSObject, NSCoding {

    // MARK: - Properties
    var id:String = ""
    var name:String = ""
    var lastName:String = ""
    var email:String = ""
    var phone:String = ""
    var birthDate:Date = Date.today
    
    var fullName:String {
        return "\(name) \(lastName)"
    }
    
    var json:[String:Any] {
        let age = birthDate.months(untilDate: Date.today) / 12
        let json:[String:Any] = ["name": name,
                                 "lastName": lastName,
                                 "email": email,
                                 "age": age,
                                 "birthdate": birthDate.string(withFormat: "dd/MM/yyyy")]
        return json
    }

    // MARK: - Lifecycle
    override init() {
        super.init()
    }
    
    // MARK: - NSCoding
    func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: "id")
        aCoder.encode(name, forKey: "name")
        aCoder.encode(lastName, forKey: "lastName")
        aCoder.encode(email, forKey: "email")
        aCoder.encode(phone, forKey: "phone")
        aCoder.encode(birthDate, forKey: "birthDate")
    }
    
    required init?(coder aDecoder: NSCoder) {
        id = aDecoder.decodeObject(forKey: "id") as? String ?? ""
        name = aDecoder.decodeObject(forKey: "name") as? String ?? ""
        lastName = aDecoder.decodeObject(forKey: "lastName") as? String ?? ""
        email = aDecoder.decodeObject(forKey: "email") as? String ?? ""
        phone = aDecoder.decodeObject(forKey: "phone") as? String ?? ""
        birthDate = aDecoder.decodeObject(forKey: "birthDate") as? Date ?? Date.today
    }
    
}
