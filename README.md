# Bushnell-sso-SDK 1.0

Simple and lightweight library to athunticate user from sso dedicated API.

# Installation

1. Make sure you have access to repo <https://github.com/kwanso-safyan/TestSDK> 
2. Add the following line to your Podfile:

```ruby
pod 'TestSDK', :path => "../TestSDK"
```

3. Run from project main folder: 

```bash
pod install
```

# Usage

## Import

**Swift:**

```swift
import TestSDK
```

## Initialize

**Swift:**

```swift
let ssoSDK = SSOController()
```

## Call when app did finish launching (AppDelegate)

Calling this method right after app finished launching is crucial to get the long-running background queries to work.

**Swift:**

```swift

ssoVC.setupConfiguration(
    ssoBaseUrl: "https://oidc-provider-bushnell-stage.herokuapp.com/",
    iOSClientId: "3F0PNxW8mFcLesCUUdnW",
    iOSClientSecret: "4gLTweFk8Rlljj0pMze1CLNFyzHg7v",
    bushnellBaseUrl: "https://bushnell-resource-server-stage.herokuapp.com/",
    iOSRedirectUrl: "com.ios.bushnellsso://"
)

```

## Check for sso login session in did finish launching (AppDelegate)

Call this method in did finish launching for checking user is logged in or not for selecting initial navigation.

**Swift:**

```swift
ssoSDK.validateSsoLoginStatus { login in
    if login {
        //:- load home screen
    }
}
```

## Login Auth Handler (AppDelegate)

Add this method to handle the success athuntication code.

**Swift:**

```swift

func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {

    if let host = url.scheme {
        if host.contains("com.ios.bushnellsso") {
            if let response = url.query {
                if response.contains("code=") {

                    let responseArr = url.query?.components(separatedBy: "code=")
                    ssoVC.callSSOTokenApiWithCodeCompletion(code: (responseArr?[1])!, target: (AppDel.window?.rootViewController)!) { status in
                        if status! {
                            print("Login Successfully")
                        } else {
                            print("Failed")
                        }
                    }

                    return true
                } else if response.contains("error=") {
                    // dismiss the auth tab in error case

                    ssoVC.dismissAuthTab(target: (AppDel.window?.rootViewController)!)
                    return false
                } else {
                    return false
                }
            } else if url.query == nil {
                ssoVC.reloadSafariTab(target: (AppDel.window?.rootViewController)!)
                return true
            }
        }
    }
    return false
}

```


## Check session expiry

Add this code in the home screen's  viewWillAppear method and .

**Swift:**

```swift
ssoSDK.checkSessionExpiryStatus { (isExpire) in
    if isExpire {
    //:- You need to navigate to the login screen.
    }
}
```

## Introspection Access Token

Use these lines of code in case of introspection access token .

**Swift:**

```swift
ssoVC.introspectionAccessToken { (response) in
    print(response)
}
```

## Check Refresh token

Use these lines of code in case of invalidate refresh token .

**Swift:**

```swift
ssoVC.checkRefreshToken(success: { (success, response) in
    print(success)
}) { (errorTag, message) in
    print(errorTag, message)
    //:- Logout SSO session
}
```

## Update sso user information

Add this code in the home screen's  viewWillAppear method and .

**Swift:**

```swift
let userObject = [
"first_name": "Safyan",
"last_name": "Jamil"
]

ssoSDK.updateUserInfo(userObj: userObject as AnyObject) { (status, response) in
    print(status, " -------- ", response)
}

```


## Requirements

Xcode 10+, iOS10+

## Author

Kwanso Developer <safyan.jamil@kwanso.com>

## License

BushnellSSO-SDK is internal library and not subject to any license.
