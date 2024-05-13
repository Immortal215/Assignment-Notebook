import SwiftUI

struct Homepage: View {
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
    
    @State var daterio : [Date] = [Date()]
    
    @State var val = 0
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
    @State var selectDelete : [Bool] = []
    @State var assignmentAnimation = false 
    
    @State var dateFormatter = DateFormatter()
    
    var body: some View {
        ZStack {
            
            
            VStack {
                Text("Home")
                    .font(Font.custom("SF Compact Rounded", fixedSize: (screenWidth/25)))
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
                            .padding(caughtUp ? 30 : 0)
                        
                        if loadedData == true && caughtUp != true {
                            
                            List {
                                // make this order via due date not just the info array
                                ForEach(0..<val, id: \.self) { index in
                                    
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
                                                .frame(width:0,height:0,alignment: .center)                 }
                                            
                                            
                                            Divider()
                                            
                                            VStack {
                                                HStack {
                                                    
                                                    Text(subjects[index])
                                                    
                                                    Divider()
                                                    
                                                    Text(names[index])
                                                    
                                                }
                                                
                                                Divider()
                                                    .frame(maxWidth: screenWidth/5)
                                                
                                                VStack {
                                                    Text(infoArray[index])
                                                    Divider()
                                                        .frame(maxWidth: screenWidth/3)
                                                    
                                                    
                                                    Text("Due : \(dueDates[index].formatted()) ")
                                                    
                                                    
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
                    
                    VStack {
                        Text("Other Content!")
                            .font(Font.custom("SF Compact Rounded", fixedSize: (screenWidth/25)))
                            .frame(width: screenWidth/2, height: 100, alignment: .center)
                        Divider()
                            .frame(width: 400)
                        List {
                            
                        }
                    }
                }
                
                
            }
            .animation(.interactiveSpring(response: 0.5, dampingFraction: 0.8, blendDuration: 1.0)) 
            
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
            selectDelete = Array(repeating: false, count: infoArray.count)
            dateFormatter.dateFormat = "M/d/yyyy, h:mm a"
            
            
            if infoArray != [] {
                caughtUp = false
                
                if dueDates != [] {
                    
                    
                    let sortedIndices = dueDates.indices.sorted(by: { dueDates[$0] < dueDates[$1] })
                    
                    // Rearrange all arrays based on sorted indices
                    subjects = sortedIndices.map { retrieveSubjectsArray[$0] }
                    names = sortedIndices.map { retrieveNames[$0] }
                    infoArray = sortedIndices.map { retrieveInfoArray[$0] }
                    dates = sortedIndices.map { retrieveDateArray[$0] }
                    dueDates = sortedIndices.map { retrieveDueArray[$0] }
                }
                
            } else {
                caughtUp = true
                
            }
            error = false 
            loadedData = true 
            
            val = min(infoArray.count, 3)
            
            
            
            
            
            
            
        }
    }
    
}










