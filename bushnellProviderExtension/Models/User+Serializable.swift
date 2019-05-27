//
//  User+Serializable.swift
//  bushnell-sso
//
//  Created by kwanso-ios on 4/22/19.
//  Copyright © 2019 kwanso-ios. All rights reserved.
//

import Foundation
import SwiftyJSON

private enum Keys: String {
    case Id = "id"
    case Email = "email"
    case Firstname = "firstName"
    case Lastname = "lastName"
    case EmailVerified = "emailVerified"
}

extension User {
    
    static func deserialize(dictionary: [String: AnyObject]) -> User?
    {
        
        let email = dictionary[Keys.Email.rawValue] as? String ?? ""
        let firstname = dictionary[Keys.Firstname.rawValue] as? String ?? ""
        let lastname = dictionary[Keys.Lastname.rawValue] as? String ?? ""
        let emailVerified = dictionary[Keys.EmailVerified.rawValue] as? Bool ?? false
        
        return User(id: 1, email: email, firstname: firstname, lastname: lastname, islogin: true, image: "", emailVerified: emailVerified)
    }
    
    func serialize() -> [String: AnyObject]
    {
        
        return [
            Keys.Id.rawValue: self.id as AnyObject,
            Keys.Email.rawValue: self.email as AnyObject,
            Keys.Firstname.rawValue: self.firstname as AnyObject,
            Keys.Lastname.rawValue: self.lastname as AnyObject,
            Keys.EmailVerified.rawValue: self.email as AnyObject,
        ]
    }
    
}
