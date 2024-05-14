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
                                    ForEach(dueDaters, id: \.self) { i in
                                        Text(i)
                                    }
                                } 
                                .frame(alignment: .trailing)
                                
                            }
                            
                            
                            HStack {
                                Text("Assignment Organization Order")
                                
                                Divider()
                                
                                Picker("" , selection: $organizedAssignments) { 
                                    ForEach(organizationOptions, id: \.self) { i in
                                        Text(i)
                                    }
                                }                            
                            }
                           
                        }
                    }
                    
                    VStack {
                        Text("PomoTimer")
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
