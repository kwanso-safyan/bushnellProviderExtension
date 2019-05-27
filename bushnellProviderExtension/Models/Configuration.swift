//
//  Configuration.swift
//  Alamofire
//
//  Created by kwanso-ios on 5/20/19.
//

import Foundation

class Configuration: NSObject {
    
    var ssoBaseUrl: String? = ""
    var bushnellBaseUrl: String? = ""
    var iOSClientId: String? = ""
    var iOSClientSecret: String? = ""
    var iOSCodeVerifier: String? = ""
    var iOSRedirectUrl: String = ""
    
    
    //:- For configurations
    init(ssoBaseUrl: String, iOSClientId: String, iOSClientSecret: String, bushnellBaseUrl: String, iOSRedirectUrl: String) {
        
        self.ssoBaseUrl = ssoBaseUrl
        self.bushnellBaseUrl = bushnellBaseUrl
        self.iOSClientId = iOSClientId
        self.iOSClientSecret = iOSClientSecret
        self.iOSRedirectUrl = iOSRedirectUrl
    }
    
}
