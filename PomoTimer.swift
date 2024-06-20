import SwiftUI

struct Settinger: View {
    
    @AppStorage("duedatesetter") var dueDateSetter = "One Day"
    @State var dueDaters : [String] = ["One Hour", "6 Hours", "One Day", "Two Days", "Five Days"]
    
    @AppStorage("organizedAssignments") var organizedAssignments = "Created By Descending (Recent to Oldest)"
    @State var organizationOptions : [String] = ["Created By Descending (Recent to Oldest)", "Created By Ascending (Oldest to Recent)", "Due By Descending (Recent to Oldest)", "Due By Ascending (Oldest to Recent)"]
    
    @AppStorage("pomotimer") var pomoTime = 1500
    @State var textPomo = ""
    @State var timerOptions : [String] = ["Custom", "900", "1200", "1500", "1800"]
    
    @AppStorage("breakTime") var breakTime = 300
    @State var textBreak = ""
    @State var timerOptionsBreak : [String] = ["Custom", "180", "300", "360"]
    
    @AppStorage("pomoOpened") var pomoOpened = false
    @AppStorage("opened") var opened = false
    
    
    @AppStorage("subjectcolor") var subjectColor : String = "#FFFFFF"
    @State var hexSubjectColor : Color = Color.white
    
    @AppStorage("titlecolor") var titleColor : String = "#FFFFFF"
    @State var hexTitleColor : Color = Color.white
    
    @AppStorage("descolor") var descriptionColor : String = "#FFFFFF"
    @State var hexDescriptionColor : Color = Color.white
    
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    VStack {
                        Text("Planner")
                            .fontWeight(.semibold)
                            .font(.title)
                        Divider()
                            .frame(width:150)
                        List {
                            HStack {
                                Text("Base Due Date Setting")
                                
                                Picker("",selection: $dueDateSetter) {
                                    ForEach(dueDaters, id: \.self) { i in
                                        Text(i)
                                    }
                                }
                                .frame(alignment: .trailing)
                                
                            }
                            
                            
                            HStack {
                                Text("Assignment Organization Order")
                                
                                
                                Picker("" , selection: $organizedAssignments) {
                                    ForEach(organizationOptions, id: \.self) { i in
                                        Text(i)
                                    }
                                }
                            }
                            DisclosureGroup("Color Modifications") {
                                HStack {
                                    
                                    ColorPicker("Subject", selection: $hexSubjectColor)
                                        .onChange(of: hexSubjectColor) { newValue in
                                            subjectColor = newValue.toHexString()
                                        }
                                    
                                    
                                }
                                HStack {
                                    
                                    ColorPicker("Title", selection: $hexTitleColor)
                                        .onChange(of: hexTitleColor) { i in
                                            titleColor = i.toHexString()
                                        }
                                    
                                    
                                }
                                HStack {
                                    
                                    ColorPicker("Description", selection: $hexDescriptionColor)
                                        .onChange(of: hexDescriptionColor) { newValue in
                                            descriptionColor = newValue.toHexString()
                                        }
                                    
                                    
                                    
                                }
                            }
                        }
                    }
                    
                    VStack {
                        Text("Pomodoro Timer")
                            .font(.title)
                            .fontWeight(.semibold)
                        Divider()
                            .frame(width:150)
                        
                        List {
                            //pomodoro time
                            HStack {
                                Text("Pomodoro Time")
                                
                                Picker("",selection: $pomoTime) {
                                    if timerOptions.contains(String(pomoTime)) {
                                        ForEach(timerOptions, id: \.self) { i in
                                            if i != "Custom" {
                                                if i != "1500" {
                                                    Text("\((Int(i)! / 60)) Minutes").tag((Int(i) ?? (pomoTime / 60) * 60))
                                                } else {
                                                    Text("25 Minutes (Default)").tag((Int(i) ?? (pomoTime / 60) * 60))
                                                }
                                            }
                                        }
                                        
                                    } else {
                                        if pomoTime > 60 {
                                            Text("Custom \(pomoTime / 60) Minutes").tag(pomoTime / 60)
                                        } else {
                                            Text("Custom \(pomoTime) Seconds").tag(pomoTime / 60)
                                        }
                                        Text("15 Minutes").tag(900)
                                        Text("20 Minutes").tag(1200)
                                        Text("25 Minutes (Default)").tag(1500)
                                        Text("30 Minutes").tag(1800)
                                        
                                        
                                    }
                                    
                                }
                                
                                TextField("Custom (Seconds)", text: $textPomo)
                                    .textFieldStyle(.roundedBorder)
                                    .onChange(of: textPomo) {
                                        pomoTime = (Int(textPomo) ?? 0 * 60)
                                    }
                            }
                            
                            // break time
                            HStack {
                                Text("Break Time")
                                
                                Picker("",selection: $breakTime) {
                                    if timerOptionsBreak.contains(String(breakTime)) {
                                        ForEach(timerOptionsBreak, id: \.self) { i in
                                            if i != "Custom" {
                                                if i != "300" {
                                                    Text("\((Int(i)! / 60)) Minutes").tag((Int(i) ?? (breakTime / 60) * 60))
                                                } else {
                                                    Text("5 Minutes (Default)").tag((Int(i) ?? (breakTime / 60) * 60))
                                                }
                                            }
                                        }
                                        
                                    } else {
                                        if breakTime > 60 {
                                            Text("Custom \(breakTime / 60) Minutes").tag(breakTime / 60)
                                        } else {
                                            Text("Custom \(breakTime) Seconds").tag(breakTime / 60)
                                        }
                                        
                                        Text("3 Minutes").tag(180)
                                        Text("5 Minutes (Default)").tag(300)
                                        Text("6 Minutes").tag(360)
                                        
                                        
                                    }
                                    
                                }
                                
                                TextField("Custom (Seconds)", text: $textBreak)
                                    .textFieldStyle(.roundedBorder)
                                    .onChange(of: textBreak) {
                                        breakTime = (Int(textBreak) ?? 0 * 60)
                                    }
                            }
                        }
                    }
                    
                    
                    
                }
            }
        }
        .onAppear {
            hexSubjectColor = Color(hex: subjectColor)
            hexTitleColor = Color(hex: titleColor)
            hexDescriptionColor = Color(hex: descriptionColor)
        }
        .onChange(of: pomoTime) {
            pomoOpened = false
            
            if timerOptions.contains(String(pomoTime)) == true {
                textPomo = ""
            }
            
            
        }
        .onChange(of: breakTime) {
            pomoOpened = false
            
            if timerOptionsBreak.contains(String(breakTime)) == true {
                textBreak = ""
            }
            
            
        }
    }
}

// color extension
extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted))
        var color: UInt64 = 0
        
        scanner.scanHexInt64(&color)
        
        let mask = 0x000000FF
        let red = Double(Int(color >> 16) & mask) / 255.0
        let green = Double(Int(color >> 8) & mask) / 255.0
        let blue = Double(Int(color) & mask) / 255.0
        
        self.init(red: red, green: green, blue: blue)
    }
    
    func toHexString() -> String {
        guard let components = UIColor(self).cgColor.components else { return "#FFFFFF" }
        
        let r = Int(components[0] * 255.0)
        let g = Int(components[1] * 255.0)
        let b = Int(components[2] * 255.0)
        
        return String(format: "#%02X%02X%02X", r, g, b)
    }
}
