import SwiftUI
import UserNotifications

struct Pomo: View {
    @AppStorage("pomotimer") var pomoTime = 1500
    @AppStorage("breakTime") var breakTime = 300
    @AppStorage("breaks") var breaks = 4
    @AppStorage("pomoOpened") var pomoOpened = false
    @AppStorage("opened") var opened = false
    @AppStorage("currentBreaks") var currentBreaks = 0
    @AppStorage("breakText") var breakText = false
    @State var currentColor: Color = .pink
    @AppStorage("cornerRadius") var cornerRadius = 300
    
    var timer: Timer {
        
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) {_ in
            
            progressTime += 1
            
            
        }
    }
    var hours: String {
        let time = (progressTime % 3600) / 3600
        return time < 10 ? "0\(time)" : "\(time)"
    }
    
    var minutes: String {
        let time = (progressTime % 3600) / 60
        return time < 10 ? "0\(time)" : "\(time)"
    }
    
    var seconds: String {
        
        let time = progressTime % 60
        return time < 10 ? "0\(time)" : "\(time)"
    }
    
    @AppStorage("progressTime") var progressTime = 0
    @State var myTimer:Timer?
    
    var timerPomo: Timer {
        
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) {_ in
            if progressTimePomo > 0 {
                progressTimePomo -= 1
            } else if progressTimePomo == 0 {
                if breakText == false {
                    breakText = true
                    progressTimePomo = breakTime
                    currentBreaks += 1
                } else {
                    breakText = false
                    progressTimePomo = pomoTime
                }
            }
        }
    }
    
    var minutesPomo: String {
        
        let time = (progressTimePomo % 3600) / 60
        return time < 10 ? "0\(time)" : "\(time)"
    }
    
    var secondsPomo: String {
        
        let time = progressTimePomo % 60
        return time < 10 ? "0\(time)" : "\(time)"
    }
    
    @AppStorage("progressPomo") var progressTimePomo = 0
    @State var myTimerPomo:Timer?
    @State var pomoClicked = false
    @State var textPomo = ""
    
    var body: some View {
        ZStack {
            NavigationStack {
                HStack {
                    VStack {
                        Text("Stop Watch")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        Divider()
                        
                        Text("\(hours != "00" ? "\(hours):" : "")\(minutes):\(seconds)")
                            .font(.system(size: 100))
                        
                        VStack {
                            HStack {
                                Button {
                                    timer.invalidate()
                                    myTimer?.invalidate()
                                    myTimer = timer
                                    
                                } label: {
                                    RoundedRectangle(cornerRadius: 20)
                                        .foregroundStyle(.green)
                                        .opacity(0.6)
                                        .overlay(
                                            Text("Start")
                                                .font(.custom("", fixedSize: 50))
                                                .foregroundStyle(.white)
                                                .animation(.bouncy(duration: 1, extraBounce: 0.1))
                                        )
                                        .frame(width:200, height:100)
                                    
                                    
                                }
                                
                                
                                
                                Button {
                                    myTimer?.invalidate()
                                } label: {
                                    RoundedRectangle(cornerRadius: 20)
                                        .foregroundStyle(.red)
                                        .opacity(0.6)
                                        .overlay(
                                            Text("Stop")
                                                .font(.custom("", fixedSize: 50))
                                                .foregroundStyle(.white)
                                        )
                                        .frame(width:200, height:100)
                                }
                            }
                            Button {
                                progressTime = 0
                                myTimer?.invalidate()
                            } label: {
                                RoundedRectangle(cornerRadius: 20)
                                    .foregroundStyle(.blue)
                                    .opacity(0.6)
                                
                                    .overlay(
                                        Text("Reset")
                                            .font(.custom("", fixedSize: 50))
                                            .foregroundStyle(.white)
                                    )
                                    .frame(width:200, height:100)
                                
                            }
                        }
                    }
                    Divider()
                    VStack {
                        Text("Pomodoro Timer")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        Divider()
                        Spacer()
                        Button {
                            timerPomo.invalidate()
                            myTimerPomo?.invalidate()
                            cornerRadius = Int.random(in: 1...162)
                            pomoClicked = true
                            textPomo = String(pomoTime/60)
                            
                        }  label : {
                            
                            ZStack {
                                
                                RoundedRectangle(cornerRadius: CGFloat(cornerRadius))
                                    .stroke(lineWidth: 25)
                                    .opacity(0.3)
                                    .foregroundColor(.gray)
                                    .animation(.linear(duration: 1))
                                
                                RoundedRectangle(cornerRadius: CGFloat(cornerRadius))
                                    .trim(from: 0.0, to: CGFloat(breakText ? Double(progressTimePomo)/Double(breakTime) : Double(progressTimePomo)/Double(pomoTime)))
                                    .stroke(style: StrokeStyle(lineWidth: 25, lineCap: .round, lineJoin: .round))
                                    .rotationEffect(Angle(degrees: -90.0))
                                    .animation(.linear(duration: 1))
                                    .foregroundStyle(currentColor)
                                    .opacity(0.3)
                                    .onChange(of: breakText) { i in
                                        currentColor = i ? .green : .pink
                                    }
                                
                                VStack {
                                    Text("\(minutesPomo):\(secondsPomo)")
                                        .font(.system(size: 100))
                                        .foregroundStyle(currentColor)
                                        .opacity(0.5)
                                        .padding(-100)
                                    Divider()
                                        .frame(width: 200)
                                    Text(pomoResulter(pomoTime: pomoTime, breakTime: breakTime, breakText: breakText))
                                        .font(.system(size: 18))
                                        .foregroundStyle(.white)
                                    Text(currentBreaks > 0 ? "Breaks taken : \(currentBreaks)" : "")
                                        .font(.system(size:15))
                                        .foregroundStyle(.white)
                                }
                                .offset(y: 50)
                            }
                            .frame(width:325, height: 325)
                            
                        } 
                        .alert("Change Pomo Time!", isPresented: $pomoClicked) {
                                TextField("Custom (Minutes)", text: $textPomo)
                                    .onChange(of: textPomo) {
                                        pomoTime = (Int(textPomo) ?? 0) * 60
                                        progressTimePomo = pomoTime

                                    }
                        }
            
                        Spacer()
                        VStack {
                            HStack {
                                Button {
                                    timerPomo.invalidate()
                                    myTimerPomo?.invalidate()
                                    myTimerPomo = timerPomo
                                    
                                    
                                } label: {
                                    RoundedRectangle(cornerRadius: 20)
                                        .foregroundStyle(.green)
                                        .opacity(0.6)
                                    
                                        .overlay(
                                            Text("Start")
                                                .font(.custom("", fixedSize: 50))
                                                .foregroundStyle(.white)
                                                .animation(.bouncy(duration: 1, extraBounce: 0.1))
                                        )
                                        .frame(width:200, height:100)
                                    
                                }
                                
                                Button {
                                    myTimerPomo?.invalidate()
                                } label: {
                                    RoundedRectangle(cornerRadius: 20)
                                        .foregroundStyle(.red)
                                        .opacity(0.6)
                                    
                                        .overlay(
                                            Text("Stop")
                                                .font(.custom("", fixedSize: 50))
                                                .foregroundStyle(.white)
                                        )
                                        .frame(width:200, height:100)
                                }
                            }
                            Button {
                                myTimerPomo?.invalidate()
                                progressTimePomo = pomoTime
                                breaks = 0
                                breakText = false
                                currentBreaks = 0
                                cornerRadius = 300
                            } label: {
                                RoundedRectangle(cornerRadius: 20)
                                    .foregroundStyle(.blue)
                                    .opacity(0.6)
                                
                                    .overlay(
                                        Text("Reset")
                                            .font(.custom("", fixedSize: 50))
                                            .foregroundStyle(.white)
                                    )
                                    .frame(width:200, height:100)
                            }
                        }
                    }
                }
                .animation(.snappy(duration: 0.3, extraBounce: 0.3))
            }
            
        }
        .onAppear {
            if pomoOpened == false {
                progressTimePomo = pomoTime
                pomoOpened = true
            }
            
            progressTimePomo = progressTimePomo
            
            if opened == false {
                progressTime = 0
                opened = true
            }
            progressTime = progressTime
            currentColor = breakText ? .green : .pink
        }
        
        .onChange(of: pomoTime) {
            myTimerPomo?.invalidate()
            progressTimePomo = pomoTime
        }
        .onChange(of: breakTime) {
            myTimerPomo?.invalidate()
        }
        .onChange(of: breakText) {
            scheduleTimeBasedNotification(breaker: breakText)
        }
        
    }
}

func scheduleTimeBasedNotification(breaker : Bool) {
    
    UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
        if granted {
            
            print("Permission granted")
            
            let content = UNMutableNotificationContent()
            content.title = "\(breaker ? "Break" : "Pomo") Time!"
            content.body = "\(breaker ? "Pomo" : "Break") Completed!"
            content.sound = UNNotificationSound(named: UNNotificationSoundName(rawValue: "myalarm.mp3"))
         //   content.sound = UNNotificationSound.defaultCritical
            
            
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
            
            
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            
            
            UNUserNotificationCenter.current().add(request) { error in
                if let error = error {
                    print("Error adding notification: \(error.localizedDescription)")
                } else {
                    print("Notification scheduled")
                }
            }
        } else if let error = error {
            print("Authorization error: \(error.localizedDescription)")
        } else {
            print("Permission not granted")
        }
    }
}

func pomoResulter(pomoTime : Int, breakTime : Int, breakText : Bool) -> String {

    return "\(breakText ? "Pomo" : "Break") Time : \(breakText ? (pomoTime >= 60 ? "\(pomoTime/60) Minutes (\(pomoTime)s)" : "\(pomoTime) Seconds") : (breakTime >= 60 ? "\(breakTime/60) Minutes (\(breakTime)s)" : "\(breakTime) Seconds"))"
}
