Show me the Weather
===================
A simple app to show you the weather where you are, or in any city around the world.

### To setup the project
The zip file contains a .xcworkspace file. Open this file in Xcode.

The Xcode project should contain all the files and libs necessary for the app to run. **However**, if everything was not installed, install [CocoaPods](https://cocoapods.org/) and `cd` into the folder which contains the `Podfile` and run:

```
$ pod install
```

And that should automagically link everything for you.

### To run
Connect an iPhone or use the iOS simulator. 

**Enable Location Services** and when prompted allow the app to use your location. If using the iOS Simulator then you must set a location when running the simulator.

Tap the Settings tab to find your location **manually** or **automatically**. 

#### Automatically
To ensure that your location is accurate when using an iPhone, please allow the phone to have used the GPS beforehand.

#### Manually
Enter text within the `City` and `Country Code` fields. 

For example: 

- Leeds GB 
- London UK

----
Language: Swift 2.1
Author: Gurpreet Paul (sc13gp)