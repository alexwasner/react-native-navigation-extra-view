
### WIP

#### iOS mostly working. Android TODO

# react-native-navigation-extra-view

[https://github.com/wix/react-native-navigation](React Native Navigation by Wix) is the best library I have found as a navigation solution. The biggest limitation is when  you want to render a global element outside of the navigation stack. This allows you to render that element and still have it communicate with the rest of your app.

## Getting started

`$ npm install react-native-navigation-extra-view --save`

### Mostly automatic installation

`$ react-native link react-native-navigation-extra-view`

### Manual installation


#### iOS

1. In XCode, in the project navigator, right click `Libraries` ➜ `Add Files to [your project's name]`
2. Go to `node_modules` ➜ `react-native-navigation-extra-view` and add `RNNExtraView.xcodeproj`
3. In XCode, in the project navigator, select your project. Add `libRNNExtraView.a` to your project's `Build Phases` ➜ `Link Binary With Libraries`
4. Run your project (`Cmd+R`)<

#### Android

1. Open up `android/app/src/main/java/[...]/MainActivity.java`
  - Add `import com.reactlibrary.RNNExtraViewPackage;` to the imports at the top of the file
  - Add `new RNNExtraViewPackage()` to the list returned by the `getPackages()` method
2. Append the following lines to `android/settings.gradle`:
  	```
  	include ':react-native-navigation-extra-view'
  	project(':react-native-navigation-extra-view').projectDir = new File(rootProject.projectDir, 	'../node_modules/react-native-navigation-extra-view/android')
  	```
3. Insert the following lines inside the dependencies block in `android/app/build.gradle`:
  	```
      compile project(':react-native-navigation-extra-view')
  	```


## Usage
```
import RNNExtraView from 'react-native-navigation-extra-view';
```

1. Register your view
 ```ExtraView.registerComponent('Test', () => TestComponent, stores, Provider)```
 or 
 ```ExtraView.registerComponent('Test', () => TestComponent)```

2. Start RNN app normally. In the `then`, init the view
```javascript
    Navigation.startSingleScreenApp({
      screen: {
        screen: 'MyApp.Home',
        title:  'Home',
        navigatorStyle: {...}
      }
    }).then(()=>{
      ExtraView.init('Test')
    });
```
  