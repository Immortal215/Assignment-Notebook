import SwiftUI

struct Homepage: View {
    
    @State var screenWidth = UIScreen.main.bounds.width
    @State var screenHeight = UIScreen.main.bounds.height
    
    @AppStorage("currentTab") var currentTab = "Basic List"
    
    @State var retrieveBigDic: [String: [String: [String]]] = UserDefaults.standard.dictionary(forKey: "DicKey") as? [String: [String: [String]]] ?? ["Basic List": ["subjects": [String()], "names": [String()], "description": [String()], "date": [String()]]]
    @State var bigDic: [String: [String: [String]]] = ["Basic List": ["subjects": [String()], "names": [String()], "description": [String()], "date": [String()]]]
    
    @State var retrieveDueDic: [String: [Date]] = UserDefaults.standard.dictionary(forKey: "DueDicKey") as? [String: [Date]] ?? ["Basic List": [Date()]]
    @State var dueDic: [String: [Date]] = ["Basic List": [Date()]]
    
    @State var retrieveSubjectsArray: [String] = UserDefaults.standard.array(forKey: "subjects") as? [String] ?? []
    @State var subjects: [String] = []
    
    @State var names: [String] = []
    
    @State var retrieveInfoArray: [String] = UserDefaults.standard.array(forKey: "description") as? [String] ?? []
    @State var infoArray: [String] = []
    
    @State var retrieveDateArray: [String] = UserDefaults.standard.array(forKey: "date") as? [String] ?? []
    @State var dates: [String] = []
    
    @State var retrieveDueArray: [Date] = UserDefaults.standard.array(forKey: "due") as? [Date] ?? []
    @State var dueDates: [Date] = []
    
    @State var daterio: [Date] = [Date()]
    
    @State var description = ""
    @State var name = ""
    @State var subject = ""
    @State var date = ""
    
    @State var showAlert = false
    @State var showDelete = false
    @State var loadedData = false
    @State var caughtUp = false
    @State var deleted = false
    @State var error = false
    @State var boxesFilled = false
    @State var settings = false
    @State var selectDelete: [Bool] = []
    @State var assignmentAnimation = false
    @State var notificationer = false
    @State var foregroundStyle = .green
    
    
    
    // time stuff
    @AppStorage("pomotimer") var pomoTime = 1500
    @AppStorage("breakTime") var breakTime = 300
    @AppStorage("breaks") var breaks = 4
    @AppStorage("pomoOpened") var pomoOpened = false
    @AppStorage("opened") var opened = false
    @AppStorage("breakText") var breakText = false
    
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
    
    var minutesPomo: String {
        
        let time = (progressTimePomo % 3600) / 60
        return time < 10 ? "0\(time)" : "\(time)"
    }
    
    var secondsPomo: String {
        
        let time = progressTimePomo % 60
        return time < 10 ? "0\(time)" : "\(time)"
    }
    
    @AppStorage("progressPomo") var progressTimePomo = 0
    
    @AppStorage("subjectcolor") var subjectColor: String = "#FFFFFF"
    @AppStorage("titlecolor") var titleColor: String = "#FFFFFF"
    @AppStorage("descolor") var descriptionColor: String = "#FFFFFF"
    @State var currentColor: Color = .pink
    @AppStorage("cornerRadius") var cornerRadius = 300
    
    var body: some View {
        ZStack {
            
            
            VStack {
                Text("Home")
                    .font(.system(size:75))
                    .fontWeight(.bold)
                
                Divider()
                HStack {
                    VStack {
                        Text("Most Urgent!")
                            .font(Font.custom("SF Compact Rounded", fixedSize: (screenWidth/25)))
                            .frame(width: screenWidth/2, height: 100, alignment: .center)
                        
                        Picker("",selection: $currentTab) {
                            ForEach(Array(bigDic.keys), id: \.self) { i in
                                if i.hasSuffix(" List") {
                                    Text(i).tag(i)
                                }
                            }
                        }
                        .pickerStyle(.segmented)
                        .fixedSize()
                        
                        Divider()
                            .frame(width: 400)
                        Text(currentTab == "+erder" ? "Edit Lists Below!" : caughtUp ? "You are all caught up!" : "")
                            .font(.title)
                            .padding(caughtUp ? 30 : 0)
                        
                        
                        if loadedData && bigDic[currentTab]?["description"]?.isEmpty != true && caughtUp == false {
                            
                            ScrollView {
                                
                                ForEach(0..<min(infoArray.count, 3), id: \.self) { index in
                                    Spacer()
                                    
                                    ZStack {
                                        
                                        RoundedRectangle(cornerRadius: 15)
                                            .foregroundColor(.black)
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 15)
                                                    .stroke(.gray, lineWidth: 2)
                                                    .frame(width: screenWidth/2.1)
                                                
                                            )
                                            .shadow(radius: 5)
                                            .frame(width: screenWidth/2.1)
                                        
                                        VStack {
                                            HStack {
                                                
                                                Text("")
                                                    .overlay(
                                                        Image(systemName: selectDelete[index] ? "checkmark.circle.fill" : "checkmark")
                                                            .resizable()
                                                            .frame(width: deleted ? 0 : 75, height: deleted ? 0 : 75, alignment: .center)
                                                            .scaleEffect(selectDelete[index] ? 1.0 : 0.5)
                                                            .foregroundStyle(selectDelete[index] ? .red : .blue)
                                                            .animation(.snappy(extraBounce: 0.4))
                                                        
                                                    )
                                                    .frame(width:0, height:0)
                                                
                                                // only works on mac
                                                    .onHover { hovering in
                                                        if hovering {
                                                            selectDelete[index] = true
                                                        } else {
                                                            selectDelete = Array(repeating: false, count: infoArray.count)
                                                            
                                                        }
                                                    }
                                                    .offset(x: -50)
                                                    .onTapGesture {
                                                        selectDelete[index].toggle()
                                                        
                                                        if selectDelete[index] == false {
                                                            selectDelete.remove(at: index)
                                                            infoArray.remove(at: index)
                                                            names.remove(at: index)
                                                            subjects.remove(at: index)
                                                            dates.remove(at: index)
                                                            dueDates.remove(at: index)
                                                            
                                                            bigDic[currentTab]!["names"]! = names
                                                            bigDic[currentTab]!["subjects"]! = subjects
                                                            bigDic[currentTab]!["description"]! = infoArray
                                                            bigDic[currentTab]!["date"]! = dates
                                                            dueDic[currentTab]! = dueDates
                                                            
                                                            UserDefaults.standard.set(bigDic, forKey: "DicKey")
                                                            UserDefaults.standard.set(dueDic, forKey: "DueDicKey")
                                                            
                                                            
                                                            if infoArray.isEmpty {
                                                                selectDelete = []
                                                                caughtUp = true
                                                            }
                                                        }
                                                    }
                                                
                                                
                                                
                                                //  Divider()
                                                
                                                VStack {
                                                    Spacer()
                                                    HStack {
                                                        
                                                        Text(subjects[index])
                                                            .foregroundStyle(Color(hex: subjectColor))
                                                        
                                                        Divider()
                                                        
                                                        Text(names[index])
                                                            .foregroundStyle(Color(hex: titleColor))
                                                    }
                                                    
                                                    Divider()
                                                        .frame(maxWidth: screenWidth/5)
                                                    
                                                    VStack {
                                                        Text(infoArray[index])
                                                            .foregroundStyle(Color(hex: descriptionColor))
                                                        Divider()
                                                            .frame(maxWidth: screenWidth/3)
                                                        
                                                        
                                                        Text("Due : \(dueDates[index].formatted()) ")
                                                            .fixedSize()
                                                        Spacer()
                                                    }
                                                }
                                            }
                                            
                                        }
                                        .foregroundStyle(foregroundStyler(dueDate: dueDates[index], assignment: names[index]))
                                        .onAppear {
                                            Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
                                               foregroundStyle = foregroundStyler(dueDate: dueDates[index], assignment: names[index])
                                            }
                                           styleNotification(dueDate: dueDates[index], assignment: names[index])
                                        }
                                        .offset(x: 25)
                                        .frame(width: screenWidth/2)
                                        .padding(10)
                                        
                                    }
                                    .padding(7.5)
                                    
                                }
                                
                                
                            }
                            .animation(.interactiveSpring(response: 0.5, dampingFraction: 0.8, blendDuration: 1.0))
                            
                        }
                    }
                    
                    VStack {
                        Text("Timers!")
                            .font(Font.custom("SF Compact Rounded", fixedSize: (screenWidth/25)))
                            .frame(width: screenWidth/2, height: 100, alignment: .center)
                        Divider()
                            .frame(width: 400)
                        Text(progressTimePomo == pomoTime && progressTime == 0 ? "No Timers Set!" : "")
                            .font(.title)
                        
                            .animation(.snappy(duration: 0.3, extraBounce: 0.3))
                        
                        VStack {
                            if progressTimePomo != pomoTime || progressTime != 0 {
                                ScrollView {
                                    if progressTime != 0 {
                                        HStack {
                                            Text("Stop Watch")
                                            
                                            Divider()
                                            
                                            Text("\(hours):\(minutes):\(seconds)")
                                            
                                        }
                                        .font(.system(size: 25))
                                        .fixedSize()
                                    }
                                    if progressTimePomo != pomoTime {
                                        HStack {
                                            Text("\(breakText ? "Break" : "Pomodoro") Timer")
                                                .fixedSize()
                                                .padding()
                                            
                                            
                                            ZStack {
                                                
                                                RoundedRectangle(cornerRadius: CGFloat(cornerRadius/6))
                                                    .stroke(lineWidth: 10)
                                                    .opacity(0.3)
                                                    .foregroundColor(.gray)
                                                    .animation(.linear(duration: 1))
                                                    .frame(width:75, height:75)
                                                
                                                RoundedRectangle(cornerRadius: CGFloat(cornerRadius/6))
                                                    .trim(from: 0.0, to: CGFloat(breakText ? Double(progressTimePomo)/Double(breakTime) : Double(progressTimePomo)/Double(pomoTime)))
                                                    .stroke(style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
                                                    .rotationEffect(Angle(degrees: -90.0))
                                                    .animation(.linear(duration: 1))
                                                    .foregroundStyle(currentColor)
                                                    .opacity(0.3)
                                                    .onChange(of: breakText) {
                                                        currentColor = $0 ? .green : .pink
                                                    }
                                                    .frame(width:75, height:75)
                                                
                                                Text("\(minutesPomo):\(secondsPomo)")
                                                    .frame(width:100, height:50)
                                                
                                                
                                            }
                                            .padding()
                                            
                                        }
                                        .font(.system(size:25))
                                    }
                                }
                                //.animation(.snappy(duration: 0.3))
                            }
                            
                            
                        }
                    }
                }
                
                
            }
            .animation(.interactiveSpring(response: 0.5, dampingFraction: 0.8, blendDuration: 1.0))
            
        }
        .onAppear {
            if currentTab == "+erder" {
                currentTab = "Basic List"
            }
            
            retrieveBigDic = UserDefaults.standard.dictionary(forKey: "DicKey") as? [String: [String: [String]]] ?? [:]
            retrieveDueDic = UserDefaults.standard.dictionary(forKey: "DueDicKey") as? [String : [Date]] ?? [:]
            
            bigDic = (retrieveBigDic[currentTab]?["subjects"] != nil ? retrieveBigDic : bigDic )
            dueDic = (retrieveDueDic[currentTab] != nil ? retrieveDueDic : dueDic)
            
            
            names = bigDic[currentTab]!["names"]!
            subjects = bigDic[currentTab]!["subjects"]!
            infoArray = bigDic[currentTab]!["description"]!
            dates = bigDic[currentTab]!["date"]!
            dueDates = dueDic[currentTab]!
            
            selectDelete = []
            selectDelete = Array(repeating: false, count: infoArray.count)
            DateFormatter().dateFormat = "M/d/yyyy, h:mm a"
            
            
            if bigDic[currentTab]?["description"] != [] {
                
                if dueDates != [] {
                    
                    var sortedIndices = dueDates.indices.sorted(by: { dueDates[$0] < dueDates[$1] })
                    
                    // rearrange all arrays based on sorted indices
                    subjects = sortedIndices.map { bigDic[currentTab]!["subjects"]![$0] }
                    names = sortedIndices.map { bigDic[currentTab]!["names"]![$0] }
                    infoArray = sortedIndices.map { bigDic[currentTab]!["description"]![$0] }
                    dates = sortedIndices.map { bigDic[currentTab]!["date"]![$0] }
                    dueDates = sortedIndices.map { dueDic[currentTab]![$0] }
                    selectDelete = sortedIndices.map { selectDelete[$0]}
                }
                caughtUp = false
                
            } else {
                caughtUp = true
                
            }
            
            error = false
            loadedData = true
            
            
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
        
        .onChange(of: currentTab) {
            if currentTab != "+erder" {
                retrieveBigDic = UserDefaults.standard.dictionary(forKey: "DicKey") as? [String: [String: [String]]] ?? [:]
                retrieveDueDic = UserDefaults.standard.dictionary(forKey: "DueDicKey") as? [String : [Date]] ?? [:]
                
                bigDic = (retrieveBigDic[currentTab]?["subjects"] != nil ? retrieveBigDic : bigDic )
                dueDic = (retrieveDueDic[currentTab] != nil ? retrieveDueDic : dueDic)
                
                
                names = bigDic[currentTab]!["names"]!
                subjects = bigDic[currentTab]!["subjects"]!
                infoArray = bigDic[currentTab]!["description"]!
                dates = bigDic[currentTab]!["date"]!
                dueDates = dueDic[currentTab]!
                
                
                selectDelete = Array(repeating: false, count: infoArray.count)
                DateFormatter().dateFormat = "M/d/yyyy, h:mm a"
                
                
                if infoArray != [] {
                    caughtUp = false
                    
                    if dueDates != [] {
                        var sortedIndices = dueDates.indices.sorted(by: { dueDates[$0] < dueDates[$1] })
                        
                        
                        // Rearrange all arrays based on sorted indices
                        subjects = sortedIndices.map { bigDic[currentTab]!["subjects"]![$0] }
                        names = sortedIndices.map { bigDic[currentTab]!["names"]![$0] }
                        infoArray = sortedIndices.map { bigDic[currentTab]!["description"]![$0] }
                        dates = sortedIndices.map { bigDic[currentTab]!["date"]![$0] }
                        dueDates = sortedIndices.map { dueDic[currentTab]![$0] }
                        selectDelete = sortedIndices.map { selectDelete[$0]}
                    }
                    
                    
                } else {
                    caughtUp = true
                    
                }
            }
        }
        .onChange(of: breakText) {
            scheduleTimeBasedNotification(title: "\(breakText ? "Break" : "Pomo") Time!", body: "\(breakText ? "Pomo" : "Break") Completed!", sound: UNNotificationSound(named: UNNotificationSoundName(rawValue: "myalarm.mp3")))
        }
        
    }
}

extension UserDefaults {
    static func resetDefaults() {
        if let bundleID = Bundle.main.bundleIdentifier {
            UserDefaults.standard.removePersistentDomain(forName: bundleID)
        }
    }
}

func resetDefaults() {
    let defaults = UserDefaults.standard
    let dictionary = defaults.dictionaryRepresentation()
    dictionary.keys.forEach { key in
        defaults.removeObject(forKey: key)
    }
}

func foregroundStyler(dueDate: Date, assignment: String) -> Color {
    
    if dueDate < Date().addingTimeInterval(86400) {
        if dueDate < Date().addingTimeInterval(3600) {
            return Color.red
        } else {
            return Color.orange
        }
    } else {
        return Color.green
        
    }
        
    
}

func styleNotification(dueDate: Date, assignment: String) {
    var number = 0

    Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
        if dueDate < Date().addingTimeInterval(86400) {
                if dueDate < Date().addingTimeInterval(3600) && number == 1 {
            
                    scheduleTimeBasedNotification(title: "\(assignment) is due in less than one hour!", body: "", sound: UNNotificationSound(named: UNNotificationSoundName(rawValue: "myalarm.mp3")))
                    number += 1
                    
                } else if number == 0 {
                        scheduleTimeBasedNotification(title: "\(assignment) is due in less than one day!", body: "", sound: UNNotificationSound.defaultCritical)
                        number += 1
                }
            }
    }
}
