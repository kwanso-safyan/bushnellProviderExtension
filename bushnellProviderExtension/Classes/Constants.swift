//
//  Created by kwanso-ios on 4/15/19.
//  Copyright © 2019 kwanso-ios. All rights reserved.
//
// Localized string helpers

import UIKit
import Foundation

// Shared instance shortcuts

let NOTIFICATION_CENTER = NotificationCenter.default
let MAIN_BUNDLE = Bundle.main
let MAIN_THREAD = Thread.main
let MAIN_SCREEN = UIScreen.main
let USER_DEFAULTS = UserDefaults.standard
let APPLICATION = UIApplication.shared
let CURRENT_DEVICE = UIDevice.current


// UserDefauld Keys
let IS_USER_LOGGEDIN = "IS_USER_LOGGEDIN"
let SESSION_EXPIRY_DATE = "SESSION_EXPIRY_DATE"


//:- << ------ Server path ------ >>

let TOKEN_API_PATH = "token"
let TOKEN_INTROSPECTION_API_PATH = "token/introspection"
let ME_API = "me"
let UPDATE_PROFILE = "users/update"
let LICENSE_LOG = "users/license-log"


let WEB_AUTH_BASE_URL_ONE = "auth?client_id="
let WEB_AUTH_BASE_URL_SECOND = "&response_type=code&prompt=consent&code_challenge="
let WEB_AUTH_BASE_URL_THIRD = "&scope=openid+profile+offline_access" // "+profile:edit"
let WEB_AUTH_BASE_URL_FOURTH = "&code_challenge_method=S256"
let ID_TOKEN_HINT = "&id_token_hint="

let DEFAULT_SSO_URL = "https://bushnell-sso-stage.arsplatform.com/"
let DEFAULT_BUSHNELL_URL = "https://bushnell-sso-resource-server-stage.arsplatform.com/"
