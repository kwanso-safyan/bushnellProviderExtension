//
//  CurrentUser.swift
//  bushnell-sso
//
//  Created by kwanso-ios on 4/22/19.
//  Copyright © 2019 kwanso-ios. All rights reserved.
//

import Foundation
import UIKit

private enum Keys: String {
    case Profile = "profile"
    case isLogin = "isSSOUserLogin"
    case TokenApiData = "tokenApiData"
}

class CurrentUser {
    
    static let sharedInstance = CurrentUser()
    private var defaults: UserDefaults = UserDefaults.standard
    
    var isLoggedIn: Bool?
    var userId: Int?
    var user: User?
    var tokenObject: TokenModel?
    var configSSO: Configuration?
    
    
    // MARK: - User Resp Handler's
    
    func deserialize(_ data: [String: AnyObject]) {
        
        guard let uUser = data[Keys.Profile.rawValue] as? [String: AnyObject] else {
            return
        }
        
        self.user = User.deserialize(dictionary: uUser)
        
        self.isLoggedIn = true
        
        save()
    }
    
    func save() {
        
        if let user = self.user {
            defaults.set(user.serialize(), forKey: Keys.Profile.rawValue)
            defaults.set(isLoggedIn, forKey: Keys.isLogin.rawValue)
            defaults.synchronize()
        }
    }
    
    func load() {
        
        self.isLoggedIn = defaults.object(forKey: Keys.isLogin.rawValue) as? Bool
        if self.isLoggedIn == nil {
            self.isLoggedIn = false
        }
        
        if let dictionary = defaults.object(forKey: Keys.Profile.rawValue) as? [String: AnyObject] {
            self.user = (User.deserialize(dictionary: dictionary)! as User)
            self.userId = self.user?.id
        }
    }
    
    fileprivate func wipeSSO() {
        
        self.isLoggedIn = false
        self.user = nil
        self.userId = nil
        defaults.set(isLoggedIn, forKey: Keys.isLogin.rawValue)
        defaults.removeObject(forKey: Keys.Profile.rawValue)
        defaults.removeObject(forKey: Keys.TokenApiData.rawValue)
        
        defaults.removeObject(forKey: SESSION_EXPIRY_DATE)
        
        defaults.synchronize()
    }
    
    func logOut() {
        
        wipeSSO()
    }
    
    // MARK: - Token Resp Handler's
    
    func tokenObjectDeserialization(_ data: [String: AnyObject]) {
        
        self.tokenObject = TokenModel.deserialize(dictionary: data)
        
        saveTokenInfo()
    }
    
    func saveTokenInfo() {
            
        if let tokenObj = self.tokenObject {
            defaults.set(tokenObj.serialize(), forKey: Keys.TokenApiData.rawValue)
            defaults.synchronize()
        }
    }
    
    func loadTokenInfo() {
        
        if let dictionary = defaults.object(forKey: Keys.TokenApiData.rawValue) as? [String: AnyObject] {
            self.tokenObject = (TokenModel.deserialize(dictionary: dictionary)! as TokenModel)
            /*
            self.checkSessionExpiry("") {isExpire in
                print("----- ",isExpire)
            }
            */
        }
    }
    
    
    public func checkSessionExpiry(_ completion: @escaping (Bool) -> Void) {
        
        let currentDate = Date()
        let expiryDate = USER_DEFAULTS.value(forKey: SESSION_EXPIRY_DATE) as! Date
        
        if currentDate > expiryDate {
            
            if (self.tokenObject?.refresh_token.count)! > 0 {
                //:- Call refresh token API
                BushnellAPI.sharedInstance.refreshTokenApi(refreshToken: (self.tokenObject?.refresh_token)!) { (success, response) -> Void in
                    if (success) {
                        completion(false)
                    }else {
                        
                        self.logOut()
                        completion(true)
                    }
                }
                
            } else {
                self.logOut()
                completion(true)
            }
        } else {
            completion(false)
        }
    }
    
    
    func loadSsoConfigurations(_ ssoBaseUrl: String, _ iOSClientId: String, _ iOSClientSecret: String, _ bushnellBaseUrl: String, _ iOSRedirectUrl: String, _ scopeEditProfile: String, _ scopeLicense: String) {
        
        self.configSSO = Configuration(ssoBaseUrl: ssoBaseUrl, iOSClientId: iOSClientId, iOSClientSecret: iOSClientSecret, bushnellBaseUrl: bushnellBaseUrl, iOSRedirectUrl: iOSRedirectUrl, scopeEditProfile: scopeEditProfile, scopeLicense: scopeLicense)
    }
    
}

