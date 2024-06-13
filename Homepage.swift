import SwiftUI

struct Homepage: View {
    @State var screenWidth = UIScreen.main.bounds.width
    @State var screenHeight = UIScreen.main.bounds.height
    @AppStorage("currentTab") var currentTab = "Basic List"
    
    @State var retrieveBigDic: [String: [String: [String]]] = UserDefaults.standard.dictionary(forKey: "DicKey") as? [String: [String: [String]]] ?? ["Basic List": ["broken": ["broken"]]]
    @State var bigDic: [String: [String: [String]]] = ["Basic List": ["subjects": [String()], "names": [String()], "description": [String()], "date": [String()]]]
    
    @State var retrieveDueDic: [String: [Date]] = UserDefaults.standard.dictionary(forKey: "DueDicKey") as? [String: [Date]] ?? ["Basic List": [Date()]]
    @State var dueDic: [String: [Date]] = ["Basic List": []]
    
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
    
    @State var dateFormatter = DateFormatter()
    
    
    // time stuff
    @AppStorage("pomotimer") var pomoTime = 1500
    @AppStorage("breakTime") var breakTime = 300
    @AppStorage("breaks") var breaks = 4
    @AppStorage("pomoOpened") var pomoOpened = false
    @AppStorage("opened") var opened = false
    @AppStorage("breakText") var breakText = false
    
    
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
                        Divider()
                            .frame(width: 400)
                        Text(caughtUp ? "You are all caught up!" : "")
                            .font(.title)
                        
                        
                        if loadedData == true && caughtUp != true {
                            
                            List {
                                
                                
                                ForEach(0..<min(infoArray.count, 3), id: \.self) { index in
                                    
                                    VStack {
                                        
                                        HStack {
                                            Button {
                                                
                                                selectDelete[index].toggle()
                                                
                                                if selectDelete[index] == false {
                                                    
                                                    infoArray.remove(at: index)
                                                    names.remove(at: index)
                                                    subjects.remove(at: index)
                                                    dates.remove(at: index)
                                                    dueDates.remove(at: index)
                                                    
                                                   // UserDefaults.standard.set(names, forKey: "names")
                                                    UserDefaults.standard.set(infoArray, forKey: "description")
                                                    //UserDefaults.standard.set(subjects, forKey: "subjects")
                                                    UserDefaults.standard.set(dates, forKey: "date")
                                                    UserDefaults.standard.set(dueDates, forKey: "due")
                                                    
                                                    if infoArray.isEmpty {
                                                        caughtUp = true
                                                    }
                                                    
                                                }
                                                
                                            } label: {
                                                Text("")
                                                    .overlay(
                                                        Image(systemName: selectDelete[index] ? "trash.square" : "checkmark.square")
                                                            .resizable()
                                                            .frame(width: deleted ? 0 : 75, height: deleted ? 0 : 75, alignment: .center)
                                                            .foregroundStyle(selectDelete[index] ? .red : .blue)
                                                            .offset(x:-50)
                                                        
                                                    )
                                                .frame(width:0,height:0,alignment: .center)                 }
                                            
                                            
                                            Divider()
                                            
                                            VStack {
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
                                                    
                                                    
                                                }
                                            }
                                            
                                        }
                                    }
                                    .foregroundStyle(dueDates[index] < Date().addingTimeInterval(86400) ? (dueDates[index] < Date().addingTimeInterval(3600) ? .red : .orange) : .green)
                                }
                                
                                
                                .padding(10)
                                .offset(x:100)
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
                                List {
                                    if progressTime != 0 {
                                        HStack {
                                            Text("Stop Watch")
                                            Divider()
                                                .frame(width:100)
                                            Text("\(minutes):\(seconds)")
                                        }
                                        .font(.system(size: 25))
                                    }
                                    if progressTimePomo != pomoTime {
                                        HStack {
                                            Text("\(breakText ? "Break" : "Pomodoro") Timer")
                                            Divider()
                                                .frame(width:100)
                                            Text("\(minutesPomo):\(secondsPomo)")
                                            Spacer()
                                            
                                            
                                            ZStack {
                                                
                                                RoundedRectangle(cornerRadius: CGFloat(cornerRadius/6))
                                                    .stroke(lineWidth: 10)
                                                    .opacity(0.3)
                                                    .foregroundColor(.gray)
                                                    .animation(.linear(duration: 1))
                                                
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
                                                
                                                
                                            }
                                            .frame(width:50, height:50)
                                            
                                        }
                                        .font(.system(size:25))
                                    }
                                }
                                .animation(.snappy(duration: 0.3, extraBounce: 0.3))
                            }
                            
                            
                        }
                    }
                }
                
                
            }
            .animation(.interactiveSpring(response: 0.5, dampingFraction: 0.8, blendDuration: 1.0))
            
        }
        .onAppear {
            
            retrieveBigDic = UserDefaults.standard.dictionary(forKey: "DicKey") as? [String: [String: [String]]] ?? [:]
            
            bigDic = (retrieveBigDic[currentTab]?["subjects"]! != nil ? retrieveBigDic : ["Basic List" : ["names": [""], "subjects" : [""]]] )

            names = bigDic[currentTab]!["names"]!
            subjects = bigDic[currentTab]!["subjects"]!
            
      //      retrieveSubjectsArray = UserDefaults.standard.array(forKey: "subjects") as? [String] ?? []
            retrieveDateArray = UserDefaults.standard.array(forKey: "date") as? [String] ?? []
            retrieveInfoArray = UserDefaults.standard.array(forKey: "description") as? [String] ?? []
            retrieveDueArray = UserDefaults.standard.array(forKey: "due") as? [Date] ?? []
            
            infoArray = retrieveInfoArray
          //  subjects = retrieveSubjectsArray
            dates = retrieveDateArray
            dueDates = retrieveDueArray
            selectDelete = []
            selectDelete = Array(repeating: false, count: infoArray.count)
            dateFormatter.dateFormat = "M/d/yyyy, h:mm a"
            
            
            if infoArray != [] {
                caughtUp = false
                
                if dueDates != [] {
                  
                    
                    var sortedIndices = dueDates.indices.sorted(by: { dueDates[$0] < dueDates[$1] })
                    
                    // Rearrange all arrays based on sorted indices
                    subjects = sortedIndices.map { bigDic[currentTab]!["subjects"]![$0] }
                    names = sortedIndices.map { bigDic[currentTab]!["names"]![$0] }
                    infoArray = sortedIndices.map { retrieveInfoArray[$0] }
                    dates = sortedIndices.map { retrieveDateArray[$0] }
                    dueDates = sortedIndices.map { retrieveDueArray[$0] }
                }
                
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
    }
}
