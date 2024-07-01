import SwiftUI

struct Notebook: View {
    @State var screenWidth = UIScreen.main.bounds.width
    @State var screenHeight = UIScreen.main.bounds.height
        
    @AppStorage("currentTab") var currentTab = "Basic List"
    
    @State var retrieveBigDic: [String: [String: [String]]] = UserDefaults.standard.dictionary(forKey: "DicKey") as? [String: [String: [String]]] ?? ["Basic List": ["subjects": [String()], "names": [String()], "description": [String()], "date": [String()]]]
    @State var bigDic: [String: [String: [String]]] = ["Basic List": ["subjects": [String()], "names": [String()], "description": [String()], "date": [String()]]]
    
    @State var retrieveDueDic: [String: [Date]] = UserDefaults.standard.dictionary(forKey: "DueDicKey") as? [String: [Date]] ?? ["Basic List": [Date()]]
    @State var dueDic: [String: [Date]] = ["Basic List": []]
    
    @State var subjects: [String] = []
    
    @State var names: [String] = []
    
    @State var infoArray: [String] = []
    
    @State var dates: [String] = []
    
    @State var retrieveDueArray: [Date] = UserDefaults.standard.array(forKey: "due") as? [Date] ?? []
    @State var dueDates: [Date] = []
    
    @State var createTab = ""
    @State var deleteTabs = ""
    @State var deleteWarning = false
    @State var addWarning = false
    
    @AppStorage("duedatesetter") var dueDateSetter = "One Day"
    @AppStorage("organizedAssignments") var organizedAssignments = "Created By Descending (Recent to Oldest)"
    
    @AppStorage("subjectcolor") var subjectColor: String = "#FFFFFF"
    @AppStorage("titlecolor") var titleColor: String = "#FFFFFF"
    @AppStorage("descolor") var descriptionColor: String = "#FFFFFF"
    
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
    
    var body: some View {
        ZStack {
            
            VStack {
                Text("Planner")
                    .font(.system(size: 75))
                    .fontWeight(.bold)
                
                Divider()
                
                VStack {
                    
                    // both buttons
                    HStack {
                        if currentTab != "+erder" {
                            Button {
                                infoArray = []
                                dates = []
                                dueDates = []
                                subjects = []
                                names = []
                                
                                bigDic[currentTab] = [
                                    "subjects": [],
                                    "names": [],
                                    "description": [],
                                    "date": []
                                ]
                                
                                dueDic[currentTab] = []
                                
                                UserDefaults.standard.set(dueDic, forKey: "DueDicKey")
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
                            // make assignment
                            .alert("Make Your Assignment!", isPresented: $showAlert) {
                                VStack {
                                    TextField("Title", text: $name)
                                        .foregroundStyle(Color(hex: titleColor == "#000000" ? "#FFFFFF" : titleColor))
                                    Divider()
                                    
                                    TextField("Description", text: $description)
                                        .foregroundStyle(Color(hex: descriptionColor == "#000000" ? "#FFFFFF" : descriptionColor))
                                    Divider()
                                    
                                    TextField("Subject", text: $subject)
                                        .foregroundStyle(Color(hex: subjectColor == "#000000" ? "#FFFFFF" : subjectColor))
                                    
                                    
                                    Button("Create Assignment") {
                                        print(name)
                                        
                                        if subject != "" && name != "" && description != "" {
                                            var tabDict = bigDic[currentTab]
                                            var namesArray = tabDict!["names"]!
                                            var subjectsArray = tabDict!["subjects"]!
                                            var infosArray = tabDict!["description"]!
                                            var datesArray = tabDict!["date"]!
                                            
                                            
                                            if namesArray == [] || namesArray == [""] {
                                                
                                                namesArray = []
                                                
                                                subjectsArray = []
                                                
                                                infosArray = []
                                                
                                                datesArray = []
                                                
                                            }
                                            
                                            namesArray.append(name)
                                            tabDict!["names"] = namesArray
                                            bigDic[currentTab] = tabDict
                                            names = namesArray
                                            
                                            subjectsArray.append(subject)
                                            tabDict!["subjects"] = subjectsArray
                                            bigDic[currentTab] = tabDict
                                            subjects = subjectsArray
                                            
                                            infosArray.append(description)
                                            tabDict!["description"] = infosArray
                                            bigDic[currentTab] = tabDict
                                            infoArray = infosArray
                                            
                                            datesArray.append(Date.now.formatted())
                                            tabDict!["date"] = datesArray
                                            bigDic[currentTab] = tabDict
                                            dates = datesArray
                                            
                                            UserDefaults.standard.set(bigDic, forKey: "DicKey")
                                            
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
                                            
                                            dueDic[currentTab] = dueDates
                                            
                                            UserDefaults.standard.set(dueDic, forKey: "DueDicKey")
                                            
                                            selectDelete = Array(repeating: false, count: infoArray.count)
                                            
                                            caughtUp = false
                                            deleted = false
                                            assignmentAnimation = true
                                        } else {
                                            boxesFilled = true
                                        }
                                        subject = ""
                                        name = ""
                                        description = ""
                                    }
                                }
                                
                            }
                        }
                    }
                    .alert("DID NOT ENTER SUFFICIENT DATA", isPresented: $boxesFilled) {
                        Button("Ok", role: .cancel) {}
                    }
                    .offset(x: 400, y: 35)
                    
                    
                    
                    Picker("",selection: $currentTab) {
                        ForEach(Array(bigDic.keys), id: \.self) { i in
                            if i.hasSuffix(" List") {
                                Text(i).tag(i)
                            }
                        }
                        
                        
                        Text("Edit Lists").tag("+erder")
                    }
                    .pickerStyle(.segmented)
                    .fixedSize()
                    
                    Divider()
                        .frame(width: currentTab == "+erder" ? 0 : 300)
                        .offset(x: 412.5, y: 35)
                    
                    Text(currentTab == "+erder" ? "Edit Lists Below!" : caughtUp ? "You are all caught up!" : "")
                        .font(.title)
                        .padding(caughtUp ? 30 : 0)
                    
                    
                    if loadedData && currentTab != "+erder" && bigDic[currentTab]?["description"]?.isEmpty != true && caughtUp == false && selectDelete.count == infoArray.count {
                        
                        ScrollView {
                            ForEach(infoArray.indices, id: \.self) { index in
                                
                                Spacer()
                                ZStack {
                                    RoundedRectangle(cornerRadius: 15)
                                        .foregroundColor(.black) 
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 15)
                                                .stroke(.gray, lineWidth: 2)
                                              //  .frame(width: screenWidth/2.1)
                                            
                                        )
                                        .shadow(radius: 5)
                                      //  .frame(width: screenWidth/2.1)
                                    
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
                                            
                                            // only works on mac
                                                .onHover { hovering in
                                                    if hovering {
                                                        selectDelete[index] = true
                                                    } else {
                                                        selectDelete = Array(repeating: false, count: infoArray.count)
                                                        
                                                    }
                                                }
                                                .offset(x: 50)
                                                .onChange(of: names[index]) {
                                                    selectDelete[index] = false
                                                }
                                                .onChange(of: subjects[index]) {
                                                    selectDelete[index] = false
                                                }
                                                .onChange(of: infoArray[index]) {
                                                    selectDelete[index] = false
                                                }
                                                .onChange(of: dueDates[index]) {
                                                    selectDelete[index] = false
                                                }
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
                                            
                                            VStack {
                                                HStack {
                                                    TextField("\(subjects[index])", text: $subjects[index])
                                                        .textFieldStyle(.automatic)
                                                        .fixedSize()
                                                        .foregroundStyle(Color(hex: subjectColor))
                                                        .onChange(of: infoArray) {
                                                            bigDic[currentTab]!["subjects"] = subjects
                                                            UserDefaults.standard.set(bigDic, forKey: "DicKey")
                                                        }
                                                    
                                                    Divider()
                                                    
                                                    TextField("\(names[index])", text: $names[index])
                                                        .textFieldStyle(.automatic)
                                                        .fixedSize()
                                                        .foregroundStyle(Color(hex: titleColor))
                                                        .onChange(of: names) {
                                                            bigDic[currentTab]!["names"] = names
                                                            UserDefaults.standard.set(bigDic, forKey: "DicKey")
                                                        }
                                                }
                                                
                                                Divider()
                                                    .frame(maxWidth: screenWidth / 5)
                                                
                                                VStack {
                                                        TextField("\(infoArray[index])", text: $infoArray[index])
                                                        .textFieldStyle(.automatic)
                                                        .fixedSize()
                                                        .foregroundStyle(Color(hex: descriptionColor))
                                                            .onChange(of: infoArray) {
                                                                bigDic[currentTab]!["description"] = infoArray
                                                                UserDefaults.standard.set(bigDic, forKey: "DicKey")
                                                            }
                                                   

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
                                                        .offset(x: (-1 * (screenWidth/2.4)))
                                                        .onChange(of: dueDates) {
                                                            dueDic[currentTab]! = dueDates
                                                            UserDefaults.standard.set(dueDic, forKey: "DueDicKey")
                                                        }
                                                        .datePickerStyle(.compact)
                                                        
                                                        
                                                        Text("Created: \(dates[index])")
                                                    }
                                                }
                                            }
                                            
                                        }
                                    }
                                  //  .frame(width: screenWidth/2)
                                    .padding(20)
                                }
                                .padding(7.5)

                            }
                            .foregroundStyle(.blue)
                            .padding(10)
                        }
                        .animation(.interactiveSpring(response: 0.5, dampingFraction: 0.8, blendDuration: 1.0))
                        .offset(y: 25)
                        
                        // the editing tab
                    } else if currentTab == "+erder" {
                        HStack {
                            VStack {
                                Image(systemName: "minus")
                                    .frame(width: 50, height: 25)
                                    .background(.brown, in: RoundedRectangle(cornerRadius: 10))
                                
                                Divider()
                                
                                Picker("Delete",selection: $deleteTabs) {
                                    ForEach(Array(bigDic.keys), id: \.self) { i in
                                        if i.hasSuffix(" List") {
                                            Text(i).tag(i)
                                        }
                                    }
                                }
                                .pickerStyle(.automatic)
                                
                                
                                Button {
                                    if deleteTabs != "Basic List" {
                                        bigDic.removeValue(forKey: deleteTabs)
                                        dueDic.removeValue(forKey: deleteTabs)
                                        
                                        UserDefaults.standard.set(bigDic, forKey: "DicKey")
                                        UserDefaults.standard.set(dueDic, forKey: "DueDicKey")
                                    } else {
                                        deleteWarning = true
                                    }
                                    
                                } label: {
                                    Text("Delete List")
                                }
                                
                            }
                            .alert("CAN NOT DELETE STARTER LIST", isPresented: $deleteWarning) {
                                Button("Ok"){}
                            }
                            
                            Divider()
                            
                            VStack {
                                Image(systemName: "plus")
                                    .frame(width: 50, height: 25)
                                    .background(.brown, in: RoundedRectangle(cornerRadius: 10))
                                
                                Divider()
                                
                                TextField("New List Name", text: $createTab)
                                    .textFieldStyle(.roundedBorder)
                                
                                Button {
                                    if bigDic.keys.contains(createTab) {
                                        addWarning = true
                                    } else {
                                        if createTab.hasSuffix(" List") {
                                            bigDic["\(createTab)"] = [
                                                "subjects": [],
                                                "names": [],
                                                "description": [],
                                                "date": []
                                            ]
                                            
                                            dueDic["\(createTab)"] = []
                                        } else {
                                            bigDic["\(createTab) List"] = [
                                                "subjects": [],
                                                "names": [],
                                                "description": [],
                                                "date": []
                                            ]
                                            
                                            dueDic["\(createTab) List"] = []
                                        }
                                        UserDefaults.standard.set(bigDic, forKey: "DicKey")
                                        UserDefaults.standard.set(dueDic, forKey: "DueDicKey")
                                    }
                                } label: {
                                    Text("Submit Name")
                                }
                            }
                            .alert("Already An Existing Name!", isPresented: $addWarning) {
                                Button("Ok"){}
                            }
                            
                            
                        }
                        .fixedSize()
                        
                    }
                }
            }
        }
        .onAppear {
            
         //   currentTab = "Basic List"
            
            retrieveBigDic = UserDefaults.standard.dictionary(forKey: "DicKey") as? [String: [String: [String]]] ?? [:]
            
            bigDic = (retrieveBigDic[currentTab]?["subjects"] != nil ? retrieveBigDic : bigDic )
            retrieveDueDic = UserDefaults.standard.dictionary(forKey: "DueDicKey") as? [String : [Date]] ?? [:]
            
            dueDic = (retrieveDueDic[currentTab] != nil ? retrieveDueDic : dueDic)
            
            
            names = bigDic[currentTab]!["names"]!
            subjects = bigDic[currentTab]!["subjects"]!
            infoArray = bigDic[currentTab]!["description"]!
            dates = bigDic[currentTab]!["date"]!
            dueDates = dueDic[currentTab]!
            
            
            selectDelete = []
            for _ in 0..<infoArray.count {
                selectDelete.append(false)
            }
            DateFormatter().dateFormat = "M/d/yyyy, h:mm a"
            
            if infoArray.isEmpty {
                caughtUp = true
            } else {
                caughtUp = false
            }
            error = false
            loadedData = true
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
                
                selectDelete = []
                selectDelete = Array(repeating: false, count: infoArray.count)
                
                DateFormatter().dateFormat = "M/d/yyyy, h:mm a"
                
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
}

