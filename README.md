# NewsApp
================

# Requirements

This project is part of a technical test with the following requirements:

* UI Implementation should be dased on UIKit.
* Architecutre design. Performant code.
* Avoid using third party libraries. If needed, adopt a reasoned approach.
* Testing is important, but not extensive one required.

# Implementation

### Organization
The project code is arranged by conceptual layers.

| Name                               | Description              |
| ---------------------------------- | ------------------------ |
|`Persistence` |Persistence layer that manages Favorite article id storing. The default implementation uses UserDefaults as it fits this project requirements. For a more huge project , Core data or Realm would be a better choice.|
|View Modules |Modules that include UI presented to the user. It is composed of the required secreens of the application, and their presentation logic. In addition, Article Detail favorite button is implemented as a separate component.|
|Coordinator |In charge of the navigation between screens. |
|Session Manager |Manages user session. Stores and retrieves bearer token|
|Networking | This layer manages HTTP communications. The default implementation uses URLSession |
|Commons | Groups all code that is liable to be used by many parts of the application. It includes common used code structures, as well as type aliasses and extensions among others. |

### Architecture

For the UI involved layers, `MVVM + Router` has been implemented. In addition, `Client` and `Repository` helps to extract data management logic. The author is more experienced with VIPER architecture. However, for this test it wouldn't fit as there is no need to extra abstraction of the logic.

The general binding of classes has been implemented by closures. Another suitable alternative could have been the usage of delegates. Modern iOS applications use reactive programming, with the use of 3rd party RxSwift libraries, and more recently Apple's Combine. However, for this test closures / delegates are simply the best choice. 

The navigation between screens is implemented within `Coordinator` pattern, which keeps each View module agnostic from others. `MainCoordinator` is in charge of instantiating the different ViewControllers and switching between Navigation Controllers.

As Images and bearer token are stored in the application, a `CachePolicy` protocol has been implemented in order to provide a `cleanCache()` method to remove stored data when logging out. 

Manual dependency injection is implemented in order to not use extra 3rd party tools. At first sight it could look like there is too much boilerplate code. However, among the many known benefits of dependency injection, it makes testing possible as mock dependencies can be supplied to class initializations.

### Dependencies

|Dependency |Task | Comment |
|URLSession |Networking, HTTP requests.   | |
|Security Keychain |Credentials store  |As user token is sensitive data, Credentials Store uses system provided Keychain to store it. |
|Kingfisher | Async images loading  | Usage of 3rd party libraries was not recommended on this test. However, regarding the goal of the test, the author considers that creating a system that manages asynchronous loading of images and cache control to speed up loads, is out of context. That is the reason of implementing this 3rd party dependency. It has been implemented using native Swift Package Manager. Another alternative would be AlamofireImage. However, installing that dependency implies installing all AF library, what is heavier in comparison.|
