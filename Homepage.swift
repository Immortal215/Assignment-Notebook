import SwiftUI

struct Homepage: View {
   
    var body: some View {
        TabView(selection: .constant(1),
                content:  {
            Notebook().tabItem {Text("Assignment Notebook")}.tag(1)
            Settinger().tabItem {Text("Settings")}.tag(2)
            Text("WIP").tabItem {Text("WIP")}.tag(3)
                        Text("WIP").tabItem {Text("WIP")}.tag(4)
        })
    }
}
