//
//  User.swift
//  bushnell-sso
//
//  Created by kwanso-ios on 4/22/19.
//  Copyright © 2019 kwanso-ios. All rights reserved.
//

import Foundation

class User: NSObject {
    var id: Int
    var email:String = ""
    var firstname: String = ""
    var lastname: String = ""
    var fullname: String {
        return "\(firstname) \(lastname)"
    }
    var emailVerified: Bool = false
    var isLogin: Bool = false
	
    
	// For user
    init(id: Int, email: String, firstname: String, lastname: String, islogin: Bool, image: String, emailVerified: Bool) {
        
        self.id = id
        self.email = email
        self.firstname = firstname
        self.lastname = lastname
        self.emailVerified = emailVerified
        self.isLogin = islogin
    }
    
    func isUserLogin() -> Bool {
        return self.isLogin
    }
    
    func getUserID() -> Int {
        return self.id
    }
}
