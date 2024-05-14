import SwiftUI

struct Settinger: View {
    
    @AppStorage("duedatesetter") var dueDateSetter = "One Day" 
    @State var dueDaters : [String] = ["One Hour", "6 Hours", "One Day", "Two Days"]
    
    @AppStorage("organizedAssignments") var organizedAssignments = "Created By Descending (Recent to Oldest)" 
    @State var organizationOptions : [String] = ["Created By Descending (Recent to Oldest)", "Created By Ascending (Oldest to Recent)"]
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    VStack {
                        Text("Notebook")
                        Divider()
                            .frame(width:100)
                        List {
                            HStack {
                                Text("Base Due Date Setting")
                                
                                Divider()
                                Picker("",selection: $dueDateSetter) { 
                                    ForEach(dueDaters, id: \.self) {
                                        Text($0)
                                    }
                                } 
                                .frame(alignment: .trailing)
                                
                            }
                            
                            
                            HStack {
                                Text("Assignment Organization Order")
                                
                                Divider()
                                
                                Picker("" , selection: $organizedAssignments) { 
                                    ForEach(organizationOptions, id: \.self) {
                                        Text($0)
                                    }
                                }                            
                            }
                            .frame(height:100)
                        }
                    }
                    VStack {
                        Text("WIP1")
                        Divider()
                            .frame(width:100)
                        List {
                            HStack {
                                Text("")
                                
                                Divider()
//                                Picker("",selection: $dueDateSetter) { 
//                                    ForEach(dueDaters, id: \.self) {
//                                        Text($0)
//                                    }
//                                } 
//                                .frame(alignment: .trailing)
                                
                            }
                            
                            
                            HStack {
                                Text("")
                                
                                Divider()
                                
//                                Picker("" , selection: $organizedAssignments) { 
//                                    ForEach(organizationOptions, id: \.self) {
//                                        Text($0)
//                                    }
//                                }                            
                            }
                        }
                    }
                    VStack {
                        Text("WIP2")
                        Divider()
                            .frame(width:100)
                        List {
                            HStack {
                                Text("")
                                
                                Divider()
//                                Picker("",selection: $dueDateSetter) { 
//                                    ForEach(dueDaters, id: \.self) {
//                                        Text($0)
//                                    }
//                                } 
//                                .frame(alignment: .trailing)
                                
                            }
                            
                            
                            HStack {
                                Text("")
                                
                                Divider()
                                
//                                Picker("" , selection: $organizedAssignments) { 
//                                    ForEach(organizationOptions, id: \.self) {
//                                        Text($0)
//                                    }
//                                }                            
                            }
                            
                        }
                    }
                    
                }
            }
        }        
    }
}
