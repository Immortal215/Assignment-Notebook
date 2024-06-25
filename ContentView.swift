import SwiftUI

struct ContentView: View {
    
    var body: some View {
        Divider()
        TabView {
            Homepage().tabItem {
                Image(systemName: "house.fill")
                
            }
            
            Pomo().tabItem {
                VStack {
                    Image(systemName: "timer")
                    Text("Pomo Timer")
                }
           
            }
            
            Notebook().tabItem {
                VStack {
                    Image(systemName: "text.book.closed.fill")
                    Text("Planner")
                }
              
            }
            
            
            Settinger().tabItem {
                VStack {
                    Image(systemName: "gearshape")
                    Text("Settings")
                }
                
         
            }
            
        }
       
      
    }
    
}


