//
//  ConstantsAPI.swift
//  bushnell-sso
//
//  Created by kwanso-ios on 4/22/19.
//  Copyright © 2019 kwanso-ios. All rights reserved.
//

import Foundation


let TOKEN_API_PATH = "token"
let TOKEN_INTROSPECTION_API_PATH = "token/introspection"
let ME_API = "me"
let UPDATE_PROFILE = "users/update"
let KEEP_ALIVE = ""

//:- ----------------- Server path -----------------

let WEB_AUTH_BASE_URL_ONE = "auth?client_id="
let WEB_AUTH_BASE_URL_SECOND = "&response_type=code&scope=openid+profile+offline_access&prompt=consent&code_challenge="
let WEB_AUTH_BASE_URL_THIRD = "&code_challenge_method=S256"
let ID_TOKEN_HINT = "&id_token_hint="





