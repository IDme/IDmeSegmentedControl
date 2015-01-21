# IDmeSegmentedControl
## An alternative `UISegmentedControl` that supports showing a second UILabel object in every segment.

### Background
The purpose of this project is to be able to show the number of results returned from a web request within a segmented control. The screenshots (below) delineate a hypothetical situation where one API request returns a dictionary that contains 3 arrays worth of data (Products, Offers, Promo Codes). 

The project comes with multiple delegate methods that allow for the setting/unsetting and listening of interactions for one or multiple segments.

A sample project is also included within this repository to delinate the usage of this class.

### Important Note
This is an unfinished project and is offered *as is* for a proof of concept on how to execute this type of solution. 

### Screenshots
The left screenshot shows an example of the loading state of each segment (initiated by pressing *Start All*)
The right screenshot shows an example of the loaded state of each segment (initiated by pressing *Load Results*) 

<img src="screenshots/sampleLoading.png?raw=true" width="375" height="667"/> 
<img src="screenshots/sampleLoaded.png?raw=true" width="375" height="667"/>

### Installation Instructions

#### CocoaPods Installation
```
pod 'IDmeSegmentedControl'
```

#### Manual Installation
Copy the `IDmeSegmentedControl` folder into your project. 

### Created and maintained by
[Arthur Ariel Sabintsev](http://www.sabintsev.com/) 