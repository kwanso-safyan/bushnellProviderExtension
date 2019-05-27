//
//  ConstantShortcuts_All.swift
//
//  Created by kwanso-ios on 4/15/19.
//  Copyright © 2019 kwanso-ios. All rights reserved.
//
// Localized string helpers

import UIKit
import Foundation

// Shared instance shortcuts

let NOTIFICATION_CENTER = NotificationCenter.default
let FILE_MANAGER = FileManager.default
let MAIN_BUNDLE = Bundle.main
let MAIN_THREAD = Thread.main
let MAIN_SCREEN = UIScreen.main
let USER_DEFAULTS = UserDefaults.standard
let APPLICATION = UIApplication.shared
let CURRENT_DEVICE = UIDevice.current
let MAIN_RUN_LOOP = RunLoop.main
let GENERAL_PASTEBOARD = UIPasteboard.general
let CURRENT_LANGUAGE = (Locale.current as NSLocale).object(forKey: NSLocale.Key.languageCode)!

// Network
let NETWORK_ACTIVITY = APPLICATION.isNetworkActivityIndicatorVisible
// Color consts
let CLEAR_COLOR = UIColor.clear
// Application informations
let APPLICATION_NAME = MAIN_BUNDLE.infoDictionary?[kCFBundleNameKey as String]
let APPLICATION_VERSION = MAIN_BUNDLE.object(forInfoDictionaryKey: "CFBundleVersion")
let IN_SIMULATOR = (TARGET_IPHONE_SIMULATOR != 0)


// UserDefauld Keys
let IS_USER_LOGGEDIN = "IS_USER_LOGGEDIN"
let SESSION_EXPIRY_DATE = "SESSION_EXPIRY_DATE"

// NSNotifcation

let SUCCESS_DEEPLINK_CODE = "SUCCESS_DEEPLINK_CODE_TOKEN_API"
let FAIL_DEEPLINK_CODE = "FAIL_DEEPLINK_CODE_TOKEN_API"
let NO_DEEPLINK_CODE = "NO_DEEPLINK_CODE_TOKEN_API"

// Storyboards Identfiers

let LOGIN_IDENTIFIER = "LoginViewController"
let DASHBOARD_IDENTIFIER = "DashboardViewController"
let PROFILE_IDENTIFIER = "ProfileViewController"

// Msssages

let CELLULAR_TITLE = "Cellular Network"
let CELLULAR_CONFIRMATION_MSG = "Are you sure you want to continue with cellular data?"
let NETWORK_SUCCESS = "Please connect with internet"
let NETWORK_TITLE = "Network Failure!"
let CONFIRMATION = "Confirmation!"
let LOGOUT_MSG = "Are you sure you want to logout?"
let LOGOUT_BTN_TEXT = "Logout"

let SUCCESS_TITLE = "Success"
let ALERT_TITLE = "Alert"
let WARNING_TITLE = "Warning"
let ERROR_DESCRIPTION = "error_description"
let SESSION_EXPIRE_MSG = "User session has expired."
let ALL_FIELD_MSG = "Please fill all fields."

let LOCATION_PATH = "App-Prefs:root=Privacy&path=LOCATION"
let TURN_ON_LOCATION_TITLE = "Turn on Location Services"
let TURN_ON_LOCATION_MSG = "1. Tap Settings \n2. Tap Location \n3. Tap While Using the App"
let NOT_NOW = "Not Now"
let SETTINGS = "Settings"
let OK = "Ok"

let PROFILE_UPDATE_MSG = "Your profile is successfully updated."







