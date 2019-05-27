# Bushnell Provider Extension 1.0

Simple and lightweight library to athunticate user from sso dedicated API.

# Installation

1. Make sure you have access to repo <https://github.com/kwanso-safyan/bushnellProviderExtension>
2. Clone the code in same level of directory.
3. Add the following line to your Podfile:

```ruby
pod 'bushnellProviderExtension', :path => "../bushnellProviderExtension"
```

3. Run from project main folder: 

```bash
pod install
```

# Usage

## Import

**Swift:**

```swift
import bushnellProviderExtension
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

ssoSDK.setupConfiguration(
    ssoBaseUrl: "PROVIDER_BASE_URL",
    iOSClientId: "CLIENT_ID",
    iOSClientSecret: "CLIENT_SECRET",
    bushnellBaseUrl: "RESOURCE_SERVER_BASE_URL",
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

## Login Athuntication

Add this code in login button action.

**Swift:**

```swift
@IBAction func onLoginPress(_ sender: Any) {

    ssoSDK.ssoAthuntication(target: self)
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
                    ssoSDK.callSSOTokenApiWithCodeCompletion(code: (responseArr?[1])!, target: (AppDel.window?.rootViewController)!) { status in
                        if status! {
                            print("Login Successfully")
                        } else {
                            print("Failed")
                        }
                    }

                    return true
                } else if response.contains("error=") {
                    // dismiss the auth tab in error case

                    ssoSDK.dismissAuthTab(target: (AppDel.window?.rootViewController)!)
                    return false
                } else {
                    return false
                }
            } else if url.query == nil {
                ssoSDK.reloadSafariTab(target: (AppDel.window?.rootViewController)!)
                return true
            }
        }
    }
    return false
}

```

## Logout SSO Session

### Import Safari services

Import the SFSafariViewControllerDelegate in logout button's ViewController class.

**Swift:**

```swift
import SafariServices
```

```swift
class ViewController: UIViewController, SFSafariViewControllerDelegate {
}
```

Add this code for logout button.

**Swift:**

```swift
@IBAction func onLogoutPress(_ sender: Any) {

    ssoSDK.logoutSSOAuthentication(target: self)
}
```


### Logout Session Handler Delegate method

Add this method in viewcontroller where the logout button action exist to handle the logout sso session.

**Swift:**

```swift

func safariViewController(_ controller: SFSafariViewController, didCompleteInitialLoad didLoadSuccessfully: Bool) {

    if didLoadSuccessfully {
        //:- Delete sesison info
        ssoVC.clearSSOSession()

        //:- Change the navigation to login screen.

    }

    self.dismiss(animated: true, completion: nil)
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
ssoSDK.checkAccessToken { (response) in
    print(response)
}
```

## Refresh Access Token

Use these lines of code in case of invalidate refresh token .

**Swift:**

```swift
ssoSDK.refreshAccessToken(success: { (success, response) in
    print(success)
}) { (errorTag, message) in
    print(errorTag, message)
    
    //:- Needs to clear Logout SSO session
    //:- Delete sesison info
    
    ssoSDK.clearSSOSession()
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
    print(status, " --- ", response)
}

```


## Requirements

Xcode 10+, iOS11+

## Author

Kwanso Developer <safyan.jamil@kwanso.com>

## License

BushnellSSO-SDK is internal library and not subject to any license.
