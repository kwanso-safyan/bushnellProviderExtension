# Bushnell iOS Framework Documentation (Provider)

Simple and lightweight library to athunticate user from SSO dedicated API.

# Pod setup in existing Project

 Open the project in Terminal and enter this command for Create a Podfile

```bash
pod init
```

## Installation

 Open the Podfile and add the following line to your Podfile for installing dependencies:

```ruby
pod 'bushnellProviderExtension', :path => "../bushnellProviderExtension"
```

Here is the example Podfile code just for help
```
# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'ExampleApp' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for ExampleApp
    pod 'bushnellProviderExtension', :path => "../bushnellProviderExtension"

  target 'ExampleAppTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'ExampleAppUITests' do
    inherit! :search_paths
    # Pods for testing
  end

end
```

 Save the Podfile and run this command on the terminal : 

```bash
pod install
```

After installing the pods make sure that you open the project in xcode from **.xcworkspace** extension rather than **.xcodeproj**

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
    iOSRedirectUrl: "com.ios.bushnellsso://", --EXAMPLE APP URL--
    scopeEditProfile: "profile:edit",
    scopeLicense: "license"
)

```

## Check for SSO login session in did finish launching (AppDelegate)

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
                } else if response.contains("logout=true") {
                    //:- Delete sesison info
                    ssoSDK.clearSSOSession()

                    //:- Load the login screen.

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
import bushnellProviderExtension
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

    self.dismiss(animated: true, completion: nil)
}

```

## Get User Object

Use these lines of code if you want to get legged-in user info

**Swift:**

```swift
ssoSDK.getUserInfo { (userObject) in
    print(userObject)
}
```

## Check session expiry

Add this code in the home screen's  viewWillAppear method

**Swift:**

```swift
ssoSDK.checkSessionExpiryStatus { (isExpire) in
    if isExpire {
    //:- You need to navigate to the login screen.
    }
}
```

## Check Access Token

Use these lines of code if you want to check for access token

**Swift:**

```swift
ssoSDK.checkAccessToken { (response) in
    print(response)
}
```

## Get Access Token Object

Use these lines of code if you want to get access token object

**Swift:**

```swift
ssoSDK.getTokenInfo { (tokenObject) in
    print(tokenObject)
}
```


## Refresh Access Token On Demand

Use these lines of code to refresh access token

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

## Update User Profile

Add this code in the home screen's viewWillAppear method

**Swift:**

```swift
let userObject = [
"first_name": "John",
"last_name": "Doe"
]

ssoSDK.updateUserInfo(userObj: userObject as AnyObject) { (status, response) in
    print(status, " --- ", response)
}

```

## Submit License Log

Use this code snippets for log license information.

**Swift:**

```swift

ssoSDK.logLicenseInfo(deviceId: "", licenseType: "", licenseNo: "") { (success, response) in
    if success {
        // Your License info logged successfully.
    } else {
    	// Parse this error message
    	print(response["error_description"] as! String)
    }
}

```


## Requirements

Xcode 10+, iOS11+

