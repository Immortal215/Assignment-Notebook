
# Made using SwiftUi
### An app to re-organize and add structure into your life by keeping you focused and on task!

## Installation 

> [!IMPORTANT]
Use a Playgrounds or Xcode folder to run on home device

*In case any code breaks for any reason, (it won't) use this function in .onAppear*
```Swift
func resetDefaults() {
    let defaults = UserDefaults.standard
    let dictionary = defaults.dictionaryRepresentation()
    dictionary.keys.forEach { key in
        defaults.removeObject(forKey: key)
    }
}
```

## Features 

### Home Screen

* Shows the most urgent assignments in the list chosen! (3 most urgent) 

* Shows your current stopwatch and Pomo for easy viewing

### Pomo Timer

* Stopwatch to measure how long you are working and studying

* Pomodoro timer used to effectively study and take 5 (or other) minute breaks every 25 (or other) minutes

> [!NOTE]
Will send notifications to you, alerting you when a pomo or break is completed


### Planner 

* Add assignment titles, descriptions, subjects and change the due date if neccessary. (Editable afterwards as well) 

* Delete assignments individually or delete them all at once.

* MULTIPLE LISTS! You can create separate planners for different things and edit them.

> [!NOTE]
Data saves on the device.

### Settings 

* Change organization, timing, and color throughout the app

## Built and optimized for iPad Gen 10
