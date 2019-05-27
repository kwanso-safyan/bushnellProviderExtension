//
//  TokenModel.swift
//  bushnell-sso
//
//  Created by kwanso-ios on 4/22/19.
//  Copyright © 2019 kwanso-ios. All rights reserved.
//

import Foundation
import SwiftyJSON

class TokenModel: NSObject {
    
    var access_token: String
    var expires_in: Int
    var id_token: String
    var scope: String
    var token_type: String
    var refresh_token: String
    
    
    init(object: AnyObject) {
        let json = JSON(object)
        
        self.access_token = json["access_token"].stringValue
        self.expires_in = json["expires_in"].intValue
        self.id_token = json["id_token"].stringValue
        self.scope = json["scope"].stringValue
        self.token_type = json["token_type"].stringValue
        self.refresh_token = json["refresh_token"].stringValue
    }
    
    init(access_token: String, expires_in: Int, id_token: String, scope: String, token_type: String, refresh_token: String) {
        
        self.access_token = access_token
        self.expires_in = expires_in
        self.id_token = id_token
        self.scope = scope
        self.token_type = token_type
        self.refresh_token = refresh_token
    }
    
}
