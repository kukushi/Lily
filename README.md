# Lily

![Carthage Compatibility](https://img.shields.io/badge/Carthage-✔-f2a77e.svg?style=flat)
![License](https://img.shields.io/cocoapods/l/Lily.svg?style=flat)
![Platform](https://img.shields.io/cocoapods/p/Lily.svg?style=flat)

Lily is lightweight swift cache framework.

## Features

* With Lily, cache can be done in ease.
* Lily provide both memory and disk level cache with same sytax.

## Installation
### CocoaPods

In your Podfile (note that it require Cocoapods 0.36 or later):

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '8.0'
use_frameworks!

pod 'Lily'
```

### Carthage

[Carthage](https://github.com/Carthage/Carthage) is a decentralized dependency manager for Cocoa application. To install the carthage tool, you can use [Homebrew](http://brew.sh).

```bash
$ brew update
$ brew install carthage
```

To integrate Lily into your Xcode project using CocoaPods, specify it in your `Cartfile`:

```ogdl
github "kukushi/Lily" >= 0.1
```

For more information about how to use Carthage, pleasee see its [project page](https://github.com/Carthage/Carthage).

### Manually

It is not recommended to install the framework manually, but if you prefer not to use either of the aforementioned dependency managers, you can integrate Lily into your project manually. A regular way to use Lily in your project would be using Embedded Framework.

- Add Lily as a [submodule](http://git-scm.com/docs/git-submodule). In your favorite terminal, `cd` into your top-level project directory, and entering the following command:

```bash
$ git submodule add https://github.com/kukushi/Lily.git
```

- Open the `Lily` folder, and drag `Lily.xcodeproj` into the file navigator of your app project, under your app project.
- In Xcode, navigate to the target configuration window by clicking on the blue project icon, and selecting the application target under the "Targets" heading in the sidebar.
- In the tab bar at the top of that window, open the "Build Phases" panel.
- Expand the "Target Dependencies" group, and add `Lily.framework`.
- Click on the `+` button at the top left of tdemohe panel and select "New Copy Files Phase". Rename this new phase to "Copy Frameworks", set the "Destination" to "Frameworks", and add `Lily.framework`.

## Usage

### Basic

MemoryCache cache in the memory level. When the App is terminated, all is gone.

```swift
// save integer 1 with "poi" key in the default context
MemoryCache["poi"] = 1

// retrive the content of "poi" key in the default context
let poi = MemoryCache["poi"].intValue

// If you want to do something in other context, just add other key.

// save integer 1 with "poi" key in the "You" context
MemoryCache["poi", "You"] = "Poi"

// retrive the content of "poi" key in the "You" context
let poiYou = MemoryCache["poi", "You"].stringValue

```

### Cache Types

`MemoryCache` do it's work in the memory level. When the App is terminated, all content will be removed.  

`QuickCache` is base on `MemoryCache`. It'll write all the content into disk in the right time at a whole.

`DiskCache` is base on `MemoryCache`, too. It do the disk level cache every time you set content for a key.

## Requirements

* iOS 8.0 or later
* Xcode 6.3 or later

## License

Lily is released under the MIT license. See LICENSE for details.