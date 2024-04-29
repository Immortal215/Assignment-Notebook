import SwiftUI

struct Main: View {
    @State var screenWidth = UIScreen.main.bounds.width
    @State var screenHeight = UIScreen.main.bounds.height
    // @AppStorage("assignmentCount") var assignmentCount = 0
    
    @State var retrieveSubjectsArray = UserDefaults.standard.array(forKey: "subjects") as! [String]? ?? []
    @State var subjects : [String] = [String()]
    
    
    @State var retrieveNames = UserDefaults.standard.array(forKey: "names") as! [String]? ?? []
    @State var names : [String] = [String()]
    
    @State var retrieveInfoArray = UserDefaults.standard.array(forKey: "description") as! [String]? ?? []
    @State var infoArray : [String] = [String()]
    
    @State var retrieveDateArray = UserDefaults.standard.array(forKey: "date") as! [String]? ?? []
    @State var dates : [String] = [String()]
    
    @State var showAlert = false
    @State var showDelete = false
    @State var loadedData = false
    @State var caughtUp = false
    @State var description = ""
    @State var name = ""
    @State var subject = ""
    @State var date = ""
    @State var dateFormatter = DateFormatter()
    @State var deleted = false 
    
    @State var stringList = [[""], [""], [""], [""]]
    
    
    
    var body: some View {
        
        Button {
            
            names = retrieveNames 
            infoArray = retrieveInfoArray 
            subjects = retrieveSubjectsArray 
            dates = retrieveDateArray 
            dateFormatter.dateFormat = "YY, MMM d, HH:mm:"
            
            stringList[0] = names
            stringList[1] = infoArray
            stringList[2] = subjects
            stringList[3] = dates
            
            if stringList != [[""], [""], [""], [""]] {
                caughtUp = true
                loadedData = true 
            } else {
                caughtUp = false
                
            }
            
            
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
                        print(retrieveInfoArray)
                        
                        stringList[0] = []
                        stringList[1] = []
                        stringList[2] = []
                        stringList[3] = []
                        
                        deleted = true
                        caughtUp = true
                        
                    } label: {
                        VStack{
                            Image(systemName: "trash.square")
                                .resizable()
                                .frame(width: 100,height: 100, alignment: .center)
                                .foregroundStyle(.red)
                            Text("Delete All")
                                .foregroundStyle(.red)
                        }
                    }
                    
                    
                    Button {
                        showAlert.toggle()
                    } label: {
                        VStack {
                            Image(systemName: "plus.square")
                                .resizable()
                                .frame(width: 100,height: 100, alignment: .center)
                                .foregroundStyle(.green)
                            Text("Add Assignment")
                                .foregroundStyle(.green)
                            
                        }
                    }
                    .alert("Make Your Assignment!", isPresented: $showAlert) {
                        
                        TextField("Title", text: $name)
                        
                        Divider()
                        
                        TextField("Description", text: $description)
                        
                        Divider()
                        
                        TextField("Subject", text: $subject)
                        
                        Button("Create Assignment") {
                            
                            print(retrieveInfoArray)
                            names.append(name)
                            UserDefaults.standard.set(names, forKey: "names")
                            
                            infoArray.append(description)                        
                            UserDefaults.standard.set(infoArray, forKey: "description")
                            
                            
                            subjects.append(subject)
                            UserDefaults.standard.set(subjects, forKey: "subjects")
                            
                            dates.append(date)
                            UserDefaults.standard.set(dates, forKey: "dates")
                            
                            stringList[0] = names
                            stringList[1] = infoArray
                            stringList[2] = subjects
                            stringList[3] = dates
                            
                            caughtUp = false
                            deleted = false
                            print(retrieveInfoArray)
                            
                            
                            
                            
                        }
                        
                        
                    }
                    
                    
                }
                
                Text(caughtUp ? "You are all caught up!" : "")
                    .font(.title)
                    .padding(caughtUp ? 30 : 0)
                
                
                if loadedData == true {
                    
                        List {
                            
                            ForEach(stringList[0], id: \.self) { index in
                                let stringer : Int = stringList[0].firstIndex(of: index)!
                                
                                if deleted == false {
                                    VStack {
                                        HStack{  
                                            
                                            Button {
                                                
                                            } label: {
                                                Image(systemName: "checkmark.square")
                                                    .resizable()
                                                    .frame(width: deleted ? 0 : 75,height: deleted ?  0 : 75, alignment: .center)
                                                    .foregroundStyle(.blue)
                                            }
                                            Divider()
                                            
                                            VStack {
                                                HStack {
                                                    Text(stringList[0][stringer])
                                                    Divider()
                                                    Text(stringList[2][stringer])
                                                }
                                                Divider()
                                                VStack {
                                                    if !infoArray.isEmpty {
                                                        Text(stringList[1][stringer])
                                                        Divider()
                                                        
                                                        let dater = dateFormatter.date(from: stringList[3][stringer])
                                                        Text(dater ?? Date.now, format: .dateTime.hour().minute())
                                                        
                                                    }
                                                    
                                                    
                                                    // There is some problem with the date picking code
                                                    //                                    let dater = dateFormatter.date(from: stringList[3][stringer]) ?? Date()
                                                    //                                   
                                                    // WORK IN PROGRESS DATE
                                                    //                            DatePicker(
                                                    //                                        "Due Date",
                                                    //                                        selection: $dater,
                                                    //                                        displayedComponents: [.hourAndMinute, .date]
                                                    //                                    ) 
                                                    //                                    
                                                    //                                    Button {
                                                    //                                        dates.append(dater.formatted())
                                                    //                                        UserDefaults.standard.set(dates, forKey: "dates")
                                                    //                                    } label : {
                                                    //                                        Text("Append Date")
                                                    //                                    }
                                                    //                                    
                                                } 
                                                
                                            }
                                            
                                            
                                        }
                                        
                                    }
                                    .foregroundStyle(.blue)
                                    .padding(10)
                                }
                            } 
                        }  
                    
                }
                
                
                
            } 
            
        }   
        .onAppear {
            names = retrieveNames 
            infoArray = retrieveInfoArray 
            subjects = retrieveSubjectsArray 
            dates = retrieveDateArray 
            dateFormatter.dateFormat = "YY, MMM d, HH:mm:"
            
            stringList[0] = names
            stringList[1] = infoArray
            stringList[2] = subjects
            stringList[3] = dates
            
            print(stringList)
            
        }
        
        
    }
    
}

