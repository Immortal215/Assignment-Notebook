import SwiftUI

struct ContentView: View {
    
    var body: some View {
        Divider()
        TabView {
            Homepage().tabItem {
                Image(systemName: "house.fill")
             
                
            }
            
            Pomo().tabItem {
                HStack {
                    Image(systemName: "timer")
                    Text("Pomo Timer")
                }
           
            }
            
            Notebook().tabItem {
                HStack {
                    Image(systemName: "text.book.closed.fill")
                    Text("Planner")
                }
              
            }
            
            
            Settinger().tabItem {
                HStack {
                    Image(systemName: "gearshape")
                    Text("Settings")
                }
             
            }
        }
      
    }
}
