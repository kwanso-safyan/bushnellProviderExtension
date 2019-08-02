
//
//  BushnellAPI.swift
//  bushnell-sso
//
//  Created by kwanso-ios on 4/22/19.
//  Copyright © 2019 kwanso-ios. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


private struct Strings{
    static let CONTENT_TYPE = "Content-Type"
    static let AUTHORIZATION = "Authorization"
    static let CONTENT_TYPE_URL_ENCODED = "application/x-www-form-urlencoded"
    static let CONTENT_TYPE_JSON = "application/json"
}

class BushnellAPI {
    
    static let sharedInstance = BushnellAPI()
    fileprivate var alamoFireManager : Alamofire.SessionManager!
    fileprivate var defaults: UserDefaults = UserDefaults.standard
    
    init(){
        
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 60 // seconds
        configuration.timeoutIntervalForResource = 60
        self.alamoFireManager = Alamofire.SessionManager(configuration: configuration)
    }
    
    func authorizationCustomHeader() -> (String)? {
        let iOSClientId = CurrentUser.sharedInstance.configSSO?.iOSClientId
        let iOSClientSecret = CurrentUser.sharedInstance.configSSO?.iOSClientSecret
        
        guard let data = "\(iOSClientId ?? "IOS_CLIENT_ID"):\(iOSClientSecret ?? "IOS_CLIENT_SECRET")".data(using: .utf8) else { return nil }
        let credential = data.base64EncodedString(options: [])
        
        return "Basic \(credential)"
    }
    
    //API Calls
    
    func tokenApi(
        responseCode:String,
        codeVerifier:String,
        handler: @escaping (_ success: Bool, _ response: AnyObject?) -> Void
        )
    {
        let baseURL = CurrentUser.sharedInstance.configSSO?.ssoBaseUrl
        let iOSRedirectUrl = CurrentUser.sharedInstance.configSSO?.iOSRedirectUrl
        
        let requestString: NSString = "\(baseURL ?? "SSO_BASE_URL")\(TOKEN_API_PATH)" as NSString
        
        let url: NSURL = NSURL(string: requestString as String)!
        
        var request = URLRequest(url: url as URL)
        request.httpMethod = "POST"
        request.setValue(Strings.CONTENT_TYPE_URL_ENCODED, forHTTPHeaderField: Strings.CONTENT_TYPE)
        request.setValue(self.authorizationCustomHeader(), forHTTPHeaderField: Strings.AUTHORIZATION)
        
        
        let data : Data = "code=\(responseCode)&redirect_uri=\(iOSRedirectUrl ?? "IOS_REDIRECT_URL")&grant_type=authorization_code&code_verifier=\(codeVerifier)".data(using: .utf8)!
        
        request.httpBody = data
        
        self.alamoFireManager!.request(request).responseJSON { response in
            
            
            switch response.result {
            case .failure(let error):
                print(error)
                
                if let data = response.data, let responseString = String(data: data, encoding: String.Encoding.utf8) {
                    print(responseString)
                }
            case .success(let responseObject):
                print(responseObject)
            }
            
            print("Request IS: \(response.request!)")
            print("codeVerifier IS: \(codeVerifier)")
            print("responseCode IS: \(responseCode)")
            
            
            let success = response.result.isSuccess && (response.response?.statusCode == 200)
            print(success ? "SUCCESS" : "FAILURE")
            
            let result = response.result.value as? [String : AnyObject]
            
            if (success)
            {
                if (result != nil) {
                    
                    let obj = TokenModel(object: result as AnyObject)
                    let sessionExpTime = Date().addingTimeInterval(Double(obj.expires_in))
                    //let sessionExpTime = Date().addingTimeInterval(20)
                    USER_DEFAULTS.set(sessionExpTime, forKey: SESSION_EXPIRY_DATE)
                    
                    CurrentUser.sharedInstance.tokenObjectDeserialization(result!)
                    
                    handler(true, result as AnyObject)
                }
                else{
                    handler(false, result as AnyObject)
                }
            }
            else
            {
                handler(false, nil)
            }
        }
    }
    
    func refreshTokenApi(
        refreshToken:String,
        handler: @escaping (_ success: Bool, _ response: AnyObject?) -> Void
        )
    {
        let baseURL = CurrentUser.sharedInstance.configSSO?.ssoBaseUrl
        
        let requestString: NSString = "\(baseURL ?? "SSO_BASE_URL")\(TOKEN_API_PATH)" as NSString
        
        let url: NSURL = NSURL(string: requestString as String)!
        
        var request = URLRequest(url: url as URL)
        request.httpMethod = "POST"
        request.setValue(Strings.CONTENT_TYPE_URL_ENCODED, forHTTPHeaderField: Strings.CONTENT_TYPE)
        request.setValue(self.authorizationCustomHeader(), forHTTPHeaderField: Strings.AUTHORIZATION)
        
        
        let data : Data = "refresh_token=\(refreshToken)&grant_type=refresh_token".data(using: .utf8)!
        
        request.httpBody = data
        
        self.alamoFireManager!.request(request).responseJSON { response in
            
            
            switch response.result {
            case .failure(let error):
                print(error)
                
                if let data = response.data, let responseString = String(data: data, encoding: String.Encoding.utf8) {
                    print(responseString)
                }
            case .success(let responseObject):
                print(responseObject)
            }
            
            print("Request: \(response.request!)")
            
            let success = response.result.isSuccess && (response.response?.statusCode == 200)
            print(success ? "SUCCESS" : "FAILURE")
            
            let result = response.result.value as? [String : AnyObject]
            
            if (success)
            {
                if (result != nil) {
                    
                    let obj = TokenModel(object: result as AnyObject)
                    let sessionExpTime = Date().addingTimeInterval(Double(obj.expires_in))
                    USER_DEFAULTS.set(sessionExpTime, forKey: SESSION_EXPIRY_DATE)
                    
                    CurrentUser.sharedInstance.tokenObjectDeserialization(result!)
                    
                    handler(true, result as AnyObject)
                }
                else{
                    handler(false, result as AnyObject)
                }
            }
            else
            {
                handler(false, nil)
            }
        }
    }
    
    func introspectionTokenApi(
        accessToken:String,
        handler: @escaping (_ success: Bool, _ response: AnyObject?) -> Void
        )
    {
        let baseURL = CurrentUser.sharedInstance.configSSO?.ssoBaseUrl
        
        let requestString: NSString = "\(baseURL ?? "SSO_BASE_URL")\(TOKEN_INTROSPECTION_API_PATH)" as NSString
        
        let url: NSURL = NSURL(string: requestString as String)!
        
        var request = URLRequest(url: url as URL)
        request.httpMethod = "POST"
        request.setValue(Strings.CONTENT_TYPE_URL_ENCODED, forHTTPHeaderField: Strings.CONTENT_TYPE)
        request.setValue(self.authorizationCustomHeader(), forHTTPHeaderField: Strings.AUTHORIZATION)
        
        
        let data : Data = "token=\(accessToken)".data(using: .utf8)!
        
        request.httpBody = data
        
        self.alamoFireManager!.request(request).responseJSON { response in
            
            
            switch response.result {
            case .failure(let error):
                print(error)
                
                if let data = response.data, let responseString = String(data: data, encoding: String.Encoding.utf8) {
                    print(responseString)
                }
            case .success(let responseObject):
                print(responseObject)
            }
            
            print("Request: \(response.request!)")
            
            let success = response.result.isSuccess && (response.response?.statusCode == 200)
            print(success ? "SUCCESS" : "FAILURE")
            
            let result = response.result.value as? [String : AnyObject]
            
            if (success)
            {
                if (result != nil) {
                    
                    handler(true, result as AnyObject)
                }
                else{
                    handler(false, result as AnyObject)
                }
            }
            else
            {
                handler(false, nil)
            }
        }
    }
    
    func userInfoApi(
        _ accessToken: String,
        handler: @escaping (_ success: Bool, _ response: AnyObject?) -> Void
        )
    {
        let baseURL = CurrentUser.sharedInstance.configSSO?.ssoBaseUrl
        
        let requestString: NSString = "\(baseURL ?? "SSO_BASE_URL")\(ME_API)" as NSString
        let url: NSURL = NSURL(string: requestString as String)!
        
        var request = URLRequest(url: url as URL)
        request.httpMethod = "GET"
        request.setValue(Strings.CONTENT_TYPE_JSON, forHTTPHeaderField: Strings.CONTENT_TYPE)
        request.setValue(String(format:"Bearer %@",accessToken), forHTTPHeaderField: Strings.AUTHORIZATION)
        
        
        self.alamoFireManager!.request(request).responseJSON { response in
            
            print("Request: \(response.request!)")
            
            let success = response.result.isSuccess && (response.response?.statusCode == 200)
            print(success ? "SUCCESS" : "FAILURE")
            
            let result = response.result.value as? [String : AnyObject]
            
            if (success)
            {
                if (result != nil) {
                    
                    CurrentUser.sharedInstance.deserialize(result!)
                    
                    handler(true, result as AnyObject)
                }
            }
            else
            {
                handler(false, nil)
            }
            
        }
        
    }
    
    
    func updateProfileApi(
        updateObj: AnyObject,
        handler: @escaping (_ success: Bool, _ response: AnyObject?) -> Void
        )
    {
        let bushnellBaseUrl = CurrentUser.sharedInstance.configSSO?.bushnellBaseUrl
        
        let requestString: NSString = "\(bushnellBaseUrl ?? "BUSNELL_BASE_URL")\(UPDATE_PROFILE)" as NSString
        let url: NSURL = NSURL(string: requestString as String)!
        
        var request = URLRequest(url: url as URL)
        request.httpMethod = "POST"
        request.setValue(Strings.CONTENT_TYPE_URL_ENCODED, forHTTPHeaderField: Strings.CONTENT_TYPE)
        request.setValue(self.authorizationCustomHeader(), forHTTPHeaderField: Strings.AUTHORIZATION)
        
        let firstName = updateObj["first_name"] as! String
        let lastName = updateObj["last_name"] as! String
        
        
        let data : Data = "first_name=\(firstName)&last_name=\(lastName)&token=\(CurrentUser.sharedInstance.tokenObject!.access_token)".data(using: .utf8)!
        
        request.httpBody = data
        
        self.alamoFireManager!.request(request).responseJSON { response in
            
            
            switch response.result {
            case .failure(let error):
                print(error)
                
                if let data = response.data, let responseString = String(data: data, encoding: String.Encoding.utf8) {
                    print(responseString)
                }
            case .success(let responseObject):
                print(responseObject)
            }
            
            print("Request: \(response.request!)")
            
            let success = response.result.isSuccess && (response.response?.statusCode == 200)
            print(success ? "SUCCESS" : "FAILURE")
            
            let result = response.result.value as? [String : AnyObject]
            
            if (success)
            {
                if (result != nil) {
                    
                    CurrentUser.sharedInstance.deserialize(result!)
                    
                    handler(true, result as AnyObject)
                }
                else{
                    handler(false, result as AnyObject)
                }
            }
            else
            {
                handler(false, nil)
            }
        }
    }
    
    func logLicenseApi(
        licenseObj: AnyObject,
        handler: @escaping (_ success: Bool, _ response: NSDictionary?) -> Void
        )
    {
        let baseURL = CurrentUser.sharedInstance.configSSO?.bushnellBaseUrl
        
        let requestString: NSString = "\(baseURL ?? "SSO_BASE_URL")\(LICENSE_LOG)" as NSString
        
        let url: NSURL = NSURL(string: requestString as String)!
        
        var request = URLRequest(url: url as URL)
        request.httpMethod = "POST"
        request.setValue(Strings.CONTENT_TYPE_URL_ENCODED, forHTTPHeaderField: Strings.CONTENT_TYPE)
        request.setValue(self.authorizationCustomHeader(), forHTTPHeaderField: Strings.AUTHORIZATION)
        
        let deviceId = licenseObj["device_id"] as! String
        let licenseType = licenseObj["license_type"] as! String
        let licenseNo = licenseObj["license_no"] as! String
        
        let data : Data = "device_id=\(deviceId)&license_type=\(licenseType)&license_no=\(licenseNo)&token=\(CurrentUser.sharedInstance.tokenObject!.access_token)".data(using: .utf8)!
        
        request.httpBody = data
        
        self.alamoFireManager!.request(request).responseJSON { response in
            
            switch response.result {
            case .failure(let error):
                print(error)
                
                if let data = response.data, let responseString = String(data: data, encoding: String.Encoding.utf8) {
                    print(responseString)
                }
            case .success(let responseObject):
                print(responseObject)
            }
            
            print("Request: \(response.request!)")
            
            let success = response.result.isSuccess && (response.response?.statusCode == 200)
            print(success ? "SUCCESS" : "FAILURE")
            
            let result = response.result.value as? NSDictionary
            
            if (success)
            {
                if (result != nil) {
                    
                    handler(true, result)
                } else{
                    handler(false, result)
                }
            }
            else
            {
                if (result != nil) {
                    handler(false, result)
                } else{
                    handler(false, nil)
                }
            }
        }
    }
    
    
}
