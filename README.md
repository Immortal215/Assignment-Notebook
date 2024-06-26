
# Made using SwiftUi
### An app to re-organize and add structure into your life by keeping you focused and on task!

> [!Warning]
> *Built and optimized for primarily iPad Gen 10*

## Installation 

> [!IMPORTANT]
*Use a Playgrounds or Xcode folder to run on home device*

#### In case any code breaks for any reason, (it won't) use and call this function in .onAppear
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

### [Home Screen](Homepage.swift)
<hr>

* __Shows the most urgent assignments in the list chosen! (3 most urgent)__

* __Shows your current stopwatch and Pomo for easy viewing__

### [Pomo Timer](PomoTimer.swift)
<hr>

* **Stopwatch to measure how long you are working and studying**

* __Pomodoro timer used to effectively study and take 5 (or other) minute breaks every 25 (or other) minutes__

> [!NOTE]
*Will send notifications to you, alerting you when a pomo or break is completed*


### [Planner](Notebook.swift)
<hr>

* __Add assignment titles, descriptions, subjects and change the due date if neccessary. (Editable afterwards as well)__

* __Delete assignments individually or delete them all at once.__

* __MULTIPLE LISTS! You can create separate planners for different things and edit them.__

> [!NOTE]
_Data saves on the device._

### [Settings](Settings.swift)
<hr>

* __Change organization, timing, and color throughout the app__


