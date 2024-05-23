import SwiftUI

struct Notebook: View {
    @State var screenWidth = UIScreen.main.bounds.width
    @State var screenHeight = UIScreen.main.bounds.height
    
    @State var retrieveSubjectsArray = UserDefaults.standard.array(forKey: "subjects") as! [String]? ?? [String()]
    @State var subjects : [String] = [String()]
    
    @State var retrieveNames = UserDefaults.standard.array(forKey: "names") as! [String]? ?? [String()]
    @State var names : [String] = [String()]
    
    @State var retrieveInfoArray = UserDefaults.standard.array(forKey: "description") as! [String]? ?? [String()]
    @State var infoArray : [String] = [String()]
    
    @State var retrieveDateArray = UserDefaults.standard.array(forKey: "date") as! [String]? ?? []
    @State var dates : [String] = []
    
    @State var retrieveDueArray = UserDefaults.standard.array(forKey: "due") as! [Date]? ?? []
    @State var dueDates : [Date] = []
    
    @AppStorage("duedatesetter") var dueDateSetter = "One Day" 
    @AppStorage("organizedAssignments") var organizedAssignments = "Created By Descending (Recent to Oldest)"
    
    @AppStorage("subjectcolor") var subjectColor : String = "#FFFFFF"
    @AppStorage("titlecolor") var titleColor : String = "#FFFFFF"
    @AppStorage("descolor") var descriptionColor : String = "#FFFFFF"
    
    
    @State var description = ""
    @State var name = ""
    @State var subject = ""
    @State var date = ""
    @State var daterio : [Date] = [Date()]
    
    @State var showAlert = false
    @State var showDelete = false
    @State var loadedData = false
    @State var caughtUp = false
    @State var deleted = false
    @State var error = false 
    @State var boxesFilled = false
    @State var settings = false 
    @State var selectDelete : [Bool] = []
    @State var assignmentAnimation = false 
    
    @State var dateFormatter = DateFormatter()
    
    // @State var stringList = [[""], [""], [""], [""]]
    var body: some View {
        ZStack {
            Button {
                retrieveSubjectsArray = UserDefaults.standard.array(forKey: "subjects") as! [String]? ?? []
                retrieveNames = UserDefaults.standard.array(forKey: "names") as! [String]? ?? []
                retrieveDateArray = UserDefaults.standard.array(forKey: "date") as! [String]? ?? []
                retrieveDueArray = UserDefaults.standard.array(forKey: "due") as! [Date]? ?? []
                retrieveInfoArray = UserDefaults.standard.array(forKey: "description") as! [String]? ?? []
                
                if loadedData == false {
                    names = retrieveNames 
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
                    Image(systemName:loadedData ?  "checkmark.icloud.fill" : "exclamationmark.icloud.fill")
                        .resizable()
                        .frame(width: 50, height: 37.5, alignment: .center)
                        .foregroundStyle(loadedData ? .green : .red)
                    
                    Text(loadedData ? "Data Loaded" : "Need to load data")
                        .foregroundStyle(loadedData ? .green : .red)
                }
            }
            
            // 2.1 for computer 2.75 for ipad
            .offset(x: (screenWidth/2.5), y: -(screenHeight/3))
            
            VStack {
                
                Text("Planner")
                    .font(.system(size:75))
                    .fontWeight(.bold)
                
                Divider()
                VStack {
                    HStack {
                        Button {
                            
                            infoArray = []                  
                            UserDefaults.standard.set(infoArray, forKey: "description")    
                            names = []                  
                            UserDefaults.standard.set(names, forKey: "names")  
                            dates = []                  
                            UserDefaults.standard.set(dates, forKey: "date")
                            dueDates = []                  
                            UserDefaults.standard.set(dueDates, forKey: "due")
                            subjects = []                  
                            UserDefaults.standard.set(subjects, forKey: "subjects")  
                            
                            deleted = true
                            caughtUp = true
                            
                        } label: {
                            VStack{
                                Image(systemName: deleted ? "trash.fill" : "trash")
                                    .resizable()
                                    .frame(width:loadedData ?  25 : 0,height: loadedData ? 25 : 0, alignment: .center)
                                    .foregroundStyle(.red)
                                
                                Text("Delete All")
                                    .foregroundStyle(.red)
                                    .frame(width:  loadedData ? 150 : 0)
                            }
                            
                        }
                        .animation(.bouncy(duration: 1, extraBounce: 0.1))
                        
                        Button {
                            if loadedData == true {
                                showAlert.toggle()
                                
                            } else {
                                error = true 
                            }
                        } label: {
                            VStack {
                                Image(systemName: error ? "x.square" : "plus")
                                    .resizable()
                                    .foregroundStyle(error ? .red : .green)
                                    .frame(width:loadedData ?  25 : 0,height: loadedData ? 25 : 0, alignment: .center)
                                
                                Text(error ? "Load Data First!" : "Add Assignment")
                                    .foregroundStyle(error ? .red : .green)
                                    .frame(width:  loadedData ? 150 : 0)
                                
                            }
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
                                    UserDefaults.standard.set(names, forKey: "names")
                                    
                                    infoArray.append(description)                        
                                    UserDefaults.standard.set(infoArray, forKey: "description")
                                    
                                    
                                    subjects.append(subject)
                                    UserDefaults.standard.set(subjects, forKey: "subjects")
                                    
                                    
                                    dates.append(Date.now.formatted())
                                    UserDefaults.standard.set(dates, forKey: "date")
                                    
                                    if dueDateSetter == "One Day" {
                                        dueDates.append(Date(timeIntervalSinceNow: 86400))
                                    } else if dueDateSetter == "One Hour"  {
                                        dueDates.append(Date(timeIntervalSinceNow: 3600))
                                    } else if dueDateSetter == "6 Hours"  {
                                        dueDates.append(Date(timeIntervalSinceNow: 21600))
                                    } else if dueDateSetter == "Two Days"  {
                                        dueDates.append(Date(timeIntervalSinceNow: 172800))
                                    } else if dueDateSetter == "Five Days"  {
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
                    .alert("DID NOT ENTER SUFFICENT DATA",isPresented: $boxesFilled) {
                        
                        
                        Button("Ok", role:.cancel) {
                            
                        }
                    }
                    .offset(x:400, y: 35)
                    
                         Divider()  
                        .frame(width: 300)
                        .offset(x:412.5, y: 35)
                    Text(caughtUp ? "You are all caught up!" : "")
                        .font(.title)
                        .padding(caughtUp ? 30 : 0)
                    
                    if loadedData == true {
                        
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
                                                        .offset(x:-50)      
                                                    
                                                )
                                                .frame(width:0,height:0,alignment: .center)   
                                        }
                                        .offset(x:100)          
                                        
                                        Divider()
                                            .offset(x:100)
                                        
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
                                                    .offset(x:100)
                                                
                                                
                                                HStack {
                                                    Text("Due : ")
                                                        .offset(x:100)
                                                    
                                                    DatePicker(
                                                        "",
                                                        selection: $dueDates[index],
                                                        displayedComponents: [.hourAndMinute, .date]
                                                    ) 
                                                    .offset(x:-465)
                                                    .onChange(of: dueDates[index]) {
                                                        UserDefaults.standard.set(dueDates, forKey: "due")
                                                    }
                                                    
                                                    //     Divider()
                                                    Text("Created : \(dates[index])")
                                                    
                                                    
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
                        .offset(y:25)
                        
                        
                    } 
                } 
            }
        }   
        .onAppear {
            retrieveSubjectsArray = UserDefaults.standard.array(forKey: "subjects") as! [String]? ?? []
            retrieveNames = UserDefaults.standard.array(forKey: "names") as! [String]? ?? []
            retrieveDateArray = UserDefaults.standard.array(forKey: "date") as! [String]? ?? []
            retrieveInfoArray = UserDefaults.standard.array(forKey: "description") as! [String]? ?? []
            retrieveDueArray = UserDefaults.standard.array(forKey: "due") as! [Date]? ?? []
            
            names = retrieveNames 
            infoArray = retrieveInfoArray 
            subjects = retrieveSubjectsArray 
            dates = retrieveDateArray 
            dueDates = retrieveDueArray
            selectDelete = []
            for _ in 0..<infoArray.count {
                selectDelete.append(false)
            }
            dateFormatter.dateFormat = "M/d/yyyy, h:mm a"
            
            
            if infoArray != [] {
                
                if dates != [] {
                    if organizedAssignments == "Created By Descending (Recent to Oldest)" {
                        var sortedIndices = dates.indices.sorted(by: { dates[$0] > dates[$1] })
                        
                        subjects = sortedIndices.map { retrieveSubjectsArray[$0] }
                        names = sortedIndices.map { retrieveNames[$0] }
                        infoArray = sortedIndices.map { retrieveInfoArray[$0] }
                        dates = sortedIndices.map { retrieveDateArray[$0] }
                        dueDates = sortedIndices.map { retrieveDueArray[$0] }
                    } else if organizedAssignments == "Created By Ascending (Oldest to Recent)" {
                        var sortedIndices = dates.indices.sorted(by: { dates[$0] < dates[$1] })
                        
                        subjects = sortedIndices.map { retrieveSubjectsArray[$0] }
                        names = sortedIndices.map { retrieveNames[$0] }
                        infoArray = sortedIndices.map { retrieveInfoArray[$0] }
                        dates = sortedIndices.map { retrieveDateArray[$0] }
                        dueDates = sortedIndices.map { retrieveDueArray[$0] }
                    } else if organizedAssignments == "Due By Ascending (Oldest to Recent)" {
                        var sortedIndices = dates.indices.sorted(by: { dueDates[$0] > dueDates[$1] })
                        
                        subjects = sortedIndices.map { retrieveSubjectsArray[$0] }
                        names = sortedIndices.map { retrieveNames[$0] }
                        infoArray = sortedIndices.map { retrieveInfoArray[$0] }
                        dates = sortedIndices.map { retrieveDateArray[$0] }
                        dueDates = sortedIndices.map { retrieveDueArray[$0] }
                    } else if organizedAssignments == "Due By Descending (Recent to Oldest)" {
                        var sortedIndices = dates.indices.sorted(by: { dueDates[$0] < dueDates[$1] })
                        
                        subjects = sortedIndices.map { retrieveSubjectsArray[$0] }
                        names = sortedIndices.map { retrieveNames[$0] }
                        infoArray = sortedIndices.map { retrieveInfoArray[$0] }
                        dates = sortedIndices.map { retrieveDateArray[$0] }
                        dueDates = sortedIndices.map { retrieveDueArray[$0] }
                    }
                }
                caughtUp = false
                
            } else {
                caughtUp = true
                
            }
            error = false 
            loadedData = true 
            
        }
    }
}


