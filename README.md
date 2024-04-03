# Companion project for the Auth0 Blog _Calling a protected API from an iOS Swift App_ 

## Project Description

This repository contains completed version of the project featured in the Auth0 Blog **_Calling a protected API from an iOS Swift App_**. The article walks the viewer through the process of calling a protected API once integrated with [Auth0](https://auth0.com/) authentication in an iOS app based on the [SwiftUI](https://developer.apple.com/xcode/swiftui/) framework.

## Getting Started

### Prerequisites

* As an iOS project, it needs to be built on a computer running **macOS**, preferably macOS 11.6, a.k.a. “Big Sur” or later.
* The project is built using Apple’s official IDE, **Xcode** (preferably version 12 or later), which is available for download via the [macOS App Store](https://apps.apple.com/) or from the [Apple Developer site](https://developer.apple.com/xcode/).
* You’ll need an **iOS device**, either real or virtual:
	* If you want to deploy the app to a real iOS device, you’ll need a free [Apple Developer account](https://developer.apple.com/programs/), which requires an [Apple ID](https://support.apple.com/apple-id) with [two-factor authentication](https://support.apple.com/en-us/HT204915) enabled.
	* If you want to deploy the app to a virtual iOS device, you just need Xcode, which includes the Simulator (which simulates current iOS devices and operating systems), as well as a facility for downloading simulators for older iOS devices and operating systems.


### Installing and running the app

1. If you don’t already have an Auth0 account, <a href="https://auth0.com/signup" 
  data-amp-replace="CLIENT_ID" 
  data-amp-addparams="anonId=CLIENT_ID(cid-scope-cookie-fallback-name)">
  sign up for a free one</a>.
2. Clone the repo: `git clone https://github.com/auth0-blog/get-started-ios-authentication-swiftui.git`
3. Install the *Auth0.swift* package using Xcode:

	- In Xcode, select **File** → **Add Packages...**. The *Add Packages* window will appear.
	- In *Add Packages* window, enter this URL into the search field: `https://github.com/auth0/Auth0.swift.git`.
	- Select the **Auth0.swift** package that appears in the list of packages and in the **Dependency Rule** menu, select **Up to Next Major Version**.
	- Click **Add Package**.

4. Log into the Auth0 dashboard, select **Applications** → **Applications**, and register the app. The Auth0 Blog article covers this step in detail.
5. Once you have registered the app, copy these values from the app’s *Settings* page in the Auth0 dashboard:

	- `Domain`
	- `Client ID`

6. In Xcode, open the `Auth0` property list and paste the `Domain ID` and `Client ID` into the appropriate fields.
7. Select a device from Xcode’s device menu (near the center top of its window) and click the **Run** button:

![Selecting a device and running the app from Xcode](https://images.ctfassets.net/23aumh6u8s0i/3QMFg81WXJkPZeMrfxVBf2/4d2de0bdc14f5859094783f9f71a62e3/run_the_app.png)


## Additional Reading

* [**Auth0’s iOS/macOS Quickstart page:**](https://auth0.com/docs/quickstart/native/ios-swift) Provides you with a “starter” project with basic authentication built in.


## License

The code in this repository is licensed under the [Apache 2.0 License](https://www.apache.org/licenses/LICENSE-2.0).
