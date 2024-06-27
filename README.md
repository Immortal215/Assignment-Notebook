Sure! Here's the complete README with the additional example at the end:

# 📱 Made using SwiftUI
### An app built to add structure into our lives, keeping focus at the forefront.

> [!WARNING]
> ⚠️ *Built and optimized primarily for iPad Gen 10*

## 🚀 Installation 

> [!IMPORTANT]
> 🛠️ *Use Playgrounds or an Xcode project folder to run on your home device*

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
* **MULTIPLE LISTS! You can create and edit separate planners for organization** 

> [!NOTE]
> 💾 *Data saves on the device*

### [⚙️ Settings](Settings.swift)
<hr>

* **Change organization, timing, and color throughout the app**

## 📄 Basic Example Code For Use

* ### Here's an example snippet of how you might configure a basic timer in SwiftUI:

```swift
struct TimerView: View {
    var timer: Timer {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            progressTime += 1
        }
    }
    
    var minutes: String {
        let time = (progressTime % 3600) / 60
        return time < 10 ? "0\(time)" : "\(time)"
    }
    
    var seconds: String {
        let time = progressTime % 60
        return time < 10 ? "0\(time)" : "\(time)"
    }
    
    @State var progressTime = 0
    @State var myTimer: Timer?
    
    var body: some View {
        Text("\(minutes):\(seconds)")
            .font(.system(size: 100))
        
        Button("Start") {
            myTimer = timer
        } 
    }
}
```

* ### Here's an example snippet of how you might configure a simple note-adding effect in SwiftUI:

```swift
struct NoteView: View {
    @State var notes: [String] = []
    @State var newNote: String = ""

    var body: some View {
        VStack {
            TextField("Enter new note", text: $newNote)

            Button("Add Note") {
                if newNote != "" {
                    notes.append(newNote)
                    newNote = ""
                }
            }

            List(notes, id: \.self) { note in
                Text(note)
            }
        }
    }
}
```

* ### Lastly, here's an example snippet of how you might make a timer wheel:

```swift
Struct TimerWheel: View {
    @State var progress: CGFloat = 0.0
    @State var isRunning: Bool = false
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 20)
                .opacity(0.3)
                .foregroundColor(.gray)
            
            Circle()
                .trim(from: 0.0, to: progress)
                .stroke(style: StrokeStyle(lineWidth: 20, lineCap: .round, lineJoin: .round))
                .foregroundColor(.blue)
                .rotationEffect(Angle(degrees: -90))
                .animation(.linear)
            
            VStack {
                Text("\(Int(progress * 100))%")
                
                Button {
                    isRunning.toggle()
                    if isRunning {
                        startTimer()
                    } 
                } label: {
                    Text(isRunning ? "Stop" : "Start")
                }
            }
        }
        .frame(width: 200, height: 200)
    }
    
    func startTimer() {
        progress = 0.0
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
            if progress >= 1.0 || isRunning == false {
                timer.invalidate()
                isRunning = false
            } else {
                progress += 0.01
            }
        }
    
}
```

