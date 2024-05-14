import SwiftUI

struct ContentView: View {
    
    var body: some View {
        Divider()
        TabView {
            Homepage().tabItem {
                Image(systemName: "house.fill")
                
                
            }
            
            Text("WIP").tabItem {
                HStack {
                    Image(systemName: "network.slash")
                    Text("W.I.P.")
                }
            }
            
            Notebook().tabItem {
                HStack {
                    Image(systemName: "text.book.closed.fill")
                    Text("Assignment Notebook")
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
