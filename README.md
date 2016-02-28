[![Build Status](https://travis-ci.org/jcfausto/transit-app.svg?branch=master)](https://travis-ci.org/jcfausto/transit-app)

# Transit App

Aa iOS Swift application that given some routes (provided as json data) presents it to the user.

# Install

## Prerequisite

- A google maps iOS sdk key. The application already have one in place but it will only work until March 4th 2016. After that you will need to create one. you can get one here: [https://developers.google.com/maps/documentation/ios-sdk/get-api-key](https://developers.google.com/maps/documentation/ios-sdk/get-api-key)
- cocoapods gem installed
  - ```$ sudo gem install cocoapods```

## Get the app
```
$ git clone https://github.com/jcfausto/transit-app.git
$ cd transit-app
```

## Install dependencies

```
$ pod install --project-directory=TransitApp/
```

## Open and test the application
```
$ open TransitApp/TransitApp.xcworkspace/
```

- Press Command + U to run the tests

## Running

- Press Command + R to run the application

# Pods used in this application (dependencies)

- CocoaLumberjack (2.2.0)
- GoogleMaps (1.12.2)
- Nimble (3.0.0)
- Polyline (3.0.0)
- Quick (0.9.1)
- SVGKit (2.x)
- Unbox (1.3.1)

