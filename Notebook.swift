import SwiftUI

struct Notebook: View {
    @State var screenWidth = UIScreen.main.bounds.width
    @State var screenHeight = UIScreen.main.bounds.height
    @AppStorage("currentTab") var currentTab = "Basic List"
    
    @State var retrieveBigDic: [String: [String: [String]]] = UserDefaults.standard.dictionary(forKey: "DicKey") as? [String: [String: [String]]] ?? ["Basic List": ["broken": ["broken"]]]
    @State var bigDic: [String: [String: [String]]] = ["Basic List": ["subjects": [String()], "names": [String()], "description": [String()], "date": [String()]]]
    
    @State var retrieveDueDic: [String: [Date]] = UserDefaults.standard.dictionary(forKey: "DueDicKey") as? [String: [Date]] ?? ["Basic List": [Date()]]
    @State var dueDic: [String: [Date]] = ["Basic List": []]
    
    @State var retrieveSubjectsArray: [String] = UserDefaults.standard.array(forKey: "subjects") as? [String] ?? [String()]
    @State var subjects: [String] = []
    
    @State var names: [String] = []
    
    @State var retrieveInfoArray: [String] = UserDefaults.standard.array(forKey: "description") as? [String] ?? [String()]
    @State var infoArray: [String] = []
    
    @State var retrieveDateArray: [String] = UserDefaults.standard.array(forKey: "date") as? [String] ?? []
    @State var dates: [String] = []
    
    @State var retrieveDueArray: [Date] = UserDefaults.standard.array(forKey: "due") as? [Date] ?? []
    @State var dueDates: [Date] = []
    
    @AppStorage("duedatesetter") var dueDateSetter = "One Day"
    @AppStorage("organizedAssignments") var organizedAssignments = "Created By Descending (Recent to Oldest)"
    
    @AppStorage("subjectcolor") var subjectColor: String = "#FFFFFF"
    @AppStorage("titlecolor") var titleColor: String = "#FFFFFF"
    @AppStorage("descolor") var descriptionColor: String = "#FFFFFF"
    
    @State var description = ""
    @State var name = ""
    @State var subject = ""
    @State var date = ""
    @State var daterio: [Date] = [Date()]
    
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
    
    var body: some View {
        ZStack {
            Button {
                retrieveSubjectsArray = UserDefaults.standard.array(forKey: "subjects") as? [String] ?? []
                retrieveBigDic = UserDefaults.standard.dictionary(forKey: "DicKey") as? [String: [String: [String]]] ?? [:]
                retrieveDateArray = UserDefaults.standard.array(forKey: "date") as? [String] ?? []
                retrieveDueArray = UserDefaults.standard.array(forKey: "due") as? [Date] ?? []
                retrieveInfoArray = UserDefaults.standard.array(forKey: "description") as? [String] ?? []
                
                if loadedData == false {
                       names = bigDic[currentTab]?["names"] ?? []
                    infoArray = retrieveInfoArray
                    subjects = retrieveSubjectsArray
                    dates = retrieveDateArray
                    dueDates = retrieveDueArray
                    selectDelete = []
                    for _ in 0..<infoArray.count {
                        selectDelete.append(false)
                    }
                    dateFormatter.dateFormat = "M/d/yyyy, h:mm a"
                }
                
                if infoArray != [] {
                    caughtUp = false
                } else {
                    caughtUp = true
                }
                error = false
                loadedData = true
            } label: {
                VStack {
                    Image(systemName: loadedData ? "checkmark.icloud.fill" : "exclamationmark.icloud.fill")
                        .resizable()
                        .frame(width: 50, height: 37.5, alignment: .center)
                        .foregroundStyle(loadedData ? .green : .red)
                    
                    Text(loadedData ? "Data Loaded" : "Need to load data")
                        .foregroundStyle(loadedData ? .green : .red)
                }
            }
            .offset(x: (screenWidth/2.5), y: -(screenHeight/3))
            
            VStack {
                Text("Planner")
                    .font(.system(size: 75))
                    .fontWeight(.bold)
                
                Divider()
                
                VStack {
                    HStack {
                        Button {
                            infoArray = []
                            UserDefaults.standard.set(infoArray, forKey: "description")

                            dates = []
                            UserDefaults.standard.set(dates, forKey: "date")
                            dueDates = []
                            UserDefaults.standard.set(dueDates, forKey: "due")
                            subjects = []
                            UserDefaults.standard.set(subjects, forKey: "subjects")
                            bigDic = [:]
                            UserDefaults.standard.set(bigDic, forKey: "DicKey")
                            deleted = true
                            caughtUp = true
                        } label: {
                            Image(systemName: deleted ? "trash.fill" : "trash")
                                .resizable()
                                .frame(width: loadedData ? 25 : 0, height: loadedData ? 25 : 0, alignment: .center)
                                .foregroundStyle(.red)
                                .frame(width: loadedData ? 150 : 0)
                        }
                        .animation(.bouncy(duration: 1, extraBounce: 0.1))
                        
                        Button {
                            if loadedData == true {
                                showAlert.toggle()
                            } else {
                                error = true
                            }
                        } label: {
                            Image(systemName: error ? "x.square" : "plus")
                                .resizable()
                                .foregroundStyle(error ? .red : .green)
                                .frame(width: loadedData ? 25 : 0, height: loadedData ? 25 : 0, alignment: .center)
                                .frame(width: loadedData ? 150 : 0)
                        }
                        .animation(.snappy(duration: 1, extraBounce: 0.1))
                        .alert("Make Your Assignment!", isPresented: $showAlert) {
                            TextField("Title", text: $name)
                            
                            Divider()
                            
                            TextField("Description", text: $description)
                            
                            Divider()
                            
                            TextField("Subject", text: $subject)
                            
                            Button("Create Assignment") {
                                if subject != "" && name != "" && description != "" {
                                    names.append(name)
                                    if var tabDict = bigDic[currentTab] {
                                        if var namesArray = tabDict["names"] {
                                            namesArray.append(name)
                                            tabDict["names"] = namesArray
                                            bigDic[currentTab] = tabDict
                                            print(bigDic)
                                        }
                                    }
                                    
                                    UserDefaults.standard.set(bigDic, forKey: "DicKey")
                                    
                                    infoArray.append(description)
                                    UserDefaults.standard.set(infoArray, forKey: "description")
                                    
                                    subjects.append(subject)
                                    UserDefaults.standard.set(subjects, forKey: "subjects")
                                    
                                    dates.append(Date.now.formatted())
                                    UserDefaults.standard.set(dates, forKey: "date")
                                    
                                    if dueDateSetter == "One Day" {
                                        dueDates.append(Date(timeIntervalSinceNow: 86400))
                                    } else if dueDateSetter == "One Hour" {
                                        dueDates.append(Date(timeIntervalSinceNow: 3600))
                                    } else if dueDateSetter == "6 Hours" {
                                        dueDates.append(Date(timeIntervalSinceNow: 21600))
                                    } else if dueDateSetter == "Two Days" {
                                        dueDates.append(Date(timeIntervalSinceNow: 172800))
                                    } else if dueDateSetter == "Five Days" {
                                        dueDates.append(Date(timeIntervalSinceNow: 432000))
                                    }
                                    
                                    UserDefaults.standard.set(dueDates, forKey: "due")
                                    
                                    selectDelete.append(false)
                                    
                                    caughtUp = false
                                    deleted = false
                                    assignmentAnimation = true
                                } else {
                                    boxesFilled = true
                                }
                            }
                        }
                    }
                    .alert("DID NOT ENTER SUFFICIENT DATA", isPresented: $boxesFilled) {
                        Button("Ok", role: .cancel) {}
                    }
                    .offset(x: 400, y: 35)
                    
                    Divider()
                        .frame(width: 300)
                        .offset(x: 412.5, y: 35)
                    
                    Text(caughtUp ? "You are all caught up!" : "")
                        .font(.title)
                        .padding(caughtUp ? 30 : 0)
                    
                    if loadedData {
                        List {
                            ForEach(infoArray.indices, id: \.self) { index in
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
                                                
                                                UserDefaults.standard.set(names, forKey: "names")
                                                UserDefaults.standard.set(infoArray, forKey: "description")
                                                UserDefaults.standard.set(subjects, forKey: "subjects")
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
                                                )
                                        }
                                        .offset(x: 50)
                                        
                                        Divider()
                                            .offset(x: 100)
                                        
                                        VStack {
                                            HStack {
                                                TextField("\(subjects[index])", text: $subjects[index])
                                                    .textFieldStyle(.automatic)
                                                    .fixedSize()
                                                    .foregroundStyle(Color(hex: subjectColor))
                                                
                                                Divider()
                                                
                                                TextField("\(names[index])", text: $names[index])
                                                    .textFieldStyle(.automatic)
                                                    .fixedSize()
                                                    .foregroundStyle(Color(hex: titleColor))
                                            }
                                            
                                            Divider()
                                                .frame(maxWidth: screenWidth / 5)
                                            
                                            VStack {
                                                TextField("\(infoArray[index])", text: $infoArray[index])
                                                    .textFieldStyle(.automatic)
                                                    .fixedSize()
                                                    .foregroundStyle(Color(hex: descriptionColor))
                                                
                                                Divider()
                                                    .offset(x: 100)
                                                
                                                HStack {
                                                    Text("Due: ")
                                                        .offset(x: 100)
                                                    
                                                    DatePicker(
                                                        "",
                                                        selection: $dueDates[index],
                                                        displayedComponents: [.hourAndMinute, .date]
                                                    )
                                                    .offset(x: -485)
                                                    .onChange(of: dueDates[index]) { _ in
                                                        UserDefaults.standard.set(dueDates, forKey: "due")
                                                    }
                                                    
                                                    Text("Created: \(dates[index])")
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                            .foregroundStyle(.blue)
                            .padding(10)
                        }
                        .animation(.interactiveSpring(response: 0.5, dampingFraction: 0.8, blendDuration: 1.0))
                        .offset(y: 25)
                    }
                }
            }
        }
        .onAppear {
            
            retrieveBigDic = UserDefaults.standard.dictionary(forKey: "DicKey") as? [String: [String: [String]]] ?? [:]
            bigDic = retrieveBigDic
            names = bigDic[currentTab]?["names"] ?? []
            retrieveSubjectsArray = UserDefaults.standard.array(forKey: "subjects") as? [String] ?? []
            retrieveDateArray = UserDefaults.standard.array(forKey: "date") as? [String] ?? []
            retrieveInfoArray = UserDefaults.standard.array(forKey: "description") as? [String] ?? []
            retrieveDueArray = UserDefaults.standard.array(forKey: "due") as? [Date] ?? []
            
            infoArray = retrieveInfoArray
            subjects = retrieveSubjectsArray
            dates = retrieveDateArray
            dueDates = retrieveDueArray
            
            selectDelete = []
            for _ in 0..<infoArray.count {
                selectDelete.append(false)
            }
            dateFormatter.dateFormat = "M/d/yyyy, h:mm a"
            
            if infoArray.isEmpty {
                caughtUp = true
            } else {
                caughtUp = false
            }
            error = false
            loadedData = true
        }
    }
}
