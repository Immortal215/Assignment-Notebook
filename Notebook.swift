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
                settings.toggle()   
            } label: {
                VStack {
                    Image(systemName: "gear")
                        .resizable()
                        .frame(width: 50, height: 50, alignment: .center)
                        .foregroundStyle(.gray)
                        .rotationEffect(Angle(degrees: settings ? -55.0 : 30.0))
                    Text("Settings")
                        .foregroundStyle(.gray)
                }
            }
            
            // 2.1 for computer but 2.75 for ipad 
            
            .offset(x: -(screenWidth/2.5), y: -(screenHeight/2.75))
            .alert("Settings", isPresented: $settings) { 
                Button("Work In Progress", role: .cancel) {
                    
                }
            }
            .animation(.easeInOut(duration: 1))
            
            Button {
                //might work
                retrieveSubjectsArray = UserDefaults.standard.array(forKey: "subjects") as! [String]? ?? []
                retrieveNames = UserDefaults.standard.array(forKey: "names") as! [String]? ?? []
                retrieveDateArray = UserDefaults.standard.array(forKey: "date") as! [String]? ?? []
                retrieveInfoArray = UserDefaults.standard.array(forKey: "description") as! [String]? ?? []
                
                if loadedData == false {
                    names = retrieveNames 
                    infoArray = retrieveInfoArray 
                    subjects = retrieveSubjectsArray 
                    dates = retrieveDateArray 
                    selectDelete = []
                    for _ in 0..<infoArray.count {
                        selectDelete.append(false)
                    }
                    dateFormatter.dateFormat = "YY, MMM d, HH:mm"
                    
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
            .offset(x: (screenWidth/2.5), y: -(screenHeight/2.75))
            
            VStack {
                
                Text("Assignment Notebook")
                    .font(Font.custom("SF Compact Rounded", fixedSize: (screenWidth/25)))
                    .frame(width: screenWidth, height: 100, alignment: .center)
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
                            subjects = []                  
                            UserDefaults.standard.set(subjects, forKey: "subjects")  
                            
                            deleted = true
                            caughtUp = true
                            
                        } label: {
                            VStack{
                                Image(systemName: "trash.square")
                                    .resizable()
                                    .frame(width:loadedData ?  100 : 0,height: loadedData ? 100 : 0, alignment: .center)
                                    .foregroundStyle(.red)
                                
                                Text("Delete All")
                                    .foregroundStyle(.red)
                                    .frame(width:  loadedData ? 150 : 0)
                            }
                            
                        }
                        .animation(.snappy(duration: 1, extraBounce: 0.1))
                        
                        Button {
                            if loadedData == true {
                                showAlert.toggle()
                                
                            } else {
                                error = true 
                            }
                        } label: {
                            VStack {
                                Image(systemName: error ? "x.square" : "plus.square")
                                    .resizable()
                                    .foregroundStyle(error ? .red : .green)
                                    .frame(width:loadedData ?  100 : 0,height: loadedData ? 100 : 0, alignment: .center)
                                
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
                    
                    Divider()                    
                    Text(caughtUp ? "You are all caught up!" : "")
                        .font(.title)
                        .padding(caughtUp ? 30 : 0)
                    
                    if loadedData == true {
                        
                        List {
                            ForEach(infoArray.indices, id: \.self) { index in
                                let stringer = infoArray[index]
                                let dater = dateFormatter.date(from: dates[index])
                                
                                VStack {
                                    HStack {
                                        Button {
                                            selectDelete[index].toggle()
                                            
                                            if selectDelete[index] == false {
                                                infoArray.remove(at: index)
                                                names.remove(at: index)
                                                subjects.remove(at: index)
                                                dates.remove(at: index)
                                                
                                                UserDefaults.standard.set(names, forKey: "names")
                                                UserDefaults.standard.set(infoArray, forKey: "description")
                                                UserDefaults.standard.set(subjects, forKey: "subjects")
                                                UserDefaults.standard.set(dates, forKey: "date")
                                                
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
                                        
                                        Divider()
                                        
                                        VStack {
                                            HStack {
                                                Text(names[index])
                                                Divider()
                                                
                                                Text(subjects[index])
                                            }
                                            .offset(x:-100)
                                            Divider()
                                                .frame(maxWidth: screenWidth/5)
                                                .offset(x:-100)
                                            
                                            VStack {
                                                Text(stringer)
                                                    .offset(x:-100)
                                                Divider()
                                                
                                                
                                                // Dates are still using Date() not dater, idk why 
                                                
                                                Text("Made : \(dater ?? Date(), format: .dateTime.day().month().year().hour().minute())")
                                                    .offset(x:300)
                                                
                                                // There is some problem with the date picking code
                                                
                                                //                                   
                                                // WORK IN PROGRESS DATE
                                                //                                                daterio[index] = dater ?? Date()
                                                //                                                
                                                //                                                DatePicker(
                                                //                                                    "Due Date",
                                                //                                                    selection: $daterio[index],
                                                //                                                    displayedComponents: [.hourAndMinute, .date]
                                                //                                                ) 
                                                //                                                
                                                //                                                Button {
                                                //                                                    dates.append(dater.formatted() ?? Date())
                                                //                                                    UserDefaults.standard.set(dates, forKey: "date")
                                                //                                                } label : {
                                                //                                                    Text("Append Date")
                                                //                                                }
                                                
                                            } 
                                        }
                                    }
                                }  
                                
                            }
                            
                            .foregroundStyle(.blue)
                            .padding(10)
                            .offset(x:100)
                        }
                        .animation(.interactiveSpring(response: 0.5, dampingFraction: 0.8, blendDuration: 1.0)) 
                    } 
                } 
            }
        }   
        .onAppear {
            retrieveSubjectsArray = UserDefaults.standard.array(forKey: "subjects") as! [String]? ?? []
            retrieveNames = UserDefaults.standard.array(forKey: "names") as! [String]? ?? []
            retrieveDateArray = UserDefaults.standard.array(forKey: "date") as! [String]? ?? []
            retrieveInfoArray = UserDefaults.standard.array(forKey: "description") as! [String]? ?? []
            
            names = retrieveNames 
            infoArray = retrieveInfoArray 
            subjects = retrieveSubjectsArray 
            dates = retrieveDateArray 
            selectDelete = []
            for _ in 0..<infoArray.count {
                selectDelete.append(false)
            }
            dateFormatter.dateFormat = "YY, MMM d, HH:mm"
            
            
            if infoArray != [] {
                caughtUp = false
                
            } else {
                caughtUp = true
                
            }
            error = false 
            loadedData = true 
            
        }
    }
}
