# 📱 Made using SwiftUI
### An app built to add structure into our lives, keeping focus at the forefront.

> [!WARNING]
> ⚠️ *Built and optimized primarily for iPad Gen 10*

## 🚀 Installation 

> [!IMPORTANT]
> 🛠️ *Use Playgrounds or an Xcode project folder to run on your home device*

<!-- #### In case any code breaks for any reason, (it won't) use and call this function in .onAppear
```swift
func resetDefaults() {
    let defaults = UserDefaults.standard
    let dictionary = defaults.dictionaryRepresentation()
    dictionary.keys.forEach { key in
        defaults.removeObject(forKey: key)
    }
}
``` -->

## ✨ Features 

### [🏠 Home Screen](Homepage.swift)
<hr>

* **Shows the most urgent assignments in the list chosen! (3 most urgent)**
* **Shows your current stopwatch and Pomo for easy viewing**

### [⏲️ Pomo Timer](PomoTimer.swift)
<hr>

* **Stopwatch to measure how long you are working and studying**
* **Pomodoro timer used to effectively study and take 5 (or other) minute breaks every 25 (or other) minutes**

> [!NOTE]
> 🔔 *Will send notifications/alarms to you, alerting you when a pomo or break is completed*

### [📒 Planner](Notebook.swift)
<hr>

* **Add assignment titles, descriptions, subjects, and change the due date if necessary. (Editable afterward as well)**
* **Delete assignments individually or delete them all at once**
* **MULTIPLE LISTS! You can create separate planners for different things and edit them**

> [!NOTE]
> 💾 *Data saves on the device*

### [⚙️ Settings](Settings.swift)
<hr>

* **Change organization, timing, and color throughout the app**
