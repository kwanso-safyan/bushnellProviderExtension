//
//  Token_Serializable.swift
//  bushnell-sso
//
//  Created by kwanso-ios on 4/29/19.
//  Copyright © 2019 kwanso-ios. All rights reserved.
//

import Foundation
import SwiftyJSON

private enum Keys: String {
    case AccessToken = "access_token"
    case ExpiresIn = "expires_in"
    case IdToken = "id_token"
    case Scope = "scope"
    case TokenType = "token_type"
    case RefreshToken = "refresh_token"
}

extension TokenModel {
    
    static func deserialize(dictionary: [String: AnyObject]) -> TokenModel? {
        
        let accessToken = dictionary[Keys.AccessToken.rawValue] as? String ?? ""
        let expiresIn = dictionary[Keys.ExpiresIn.rawValue] as? Int ?? 0
        let idToken = dictionary[Keys.IdToken.rawValue] as? String ?? ""
        let scope = dictionary[Keys.Scope.rawValue] as? String ?? ""
        let tokenType = dictionary[Keys.TokenType.rawValue] as? String ?? ""
        let refreshToken = dictionary[Keys.RefreshToken.rawValue] as? String ?? ""
        
        return TokenModel(access_token: accessToken, expires_in: expiresIn, id_token: idToken, scope: scope, token_type: tokenType, refresh_token: refreshToken)
    }
    
    func serialize() -> [String: AnyObject] {
        
        return [
            Keys.AccessToken.rawValue: self.access_token as AnyObject,
            Keys.ExpiresIn.rawValue: self.expires_in as AnyObject,
            Keys.IdToken.rawValue: self.id_token as AnyObject,
            Keys.Scope.rawValue: self.scope as AnyObject,
            Keys.TokenType.rawValue: self.token_type as AnyObject,
            Keys.RefreshToken.rawValue: self.refresh_token as AnyObject,
        ]
    }
    
}
