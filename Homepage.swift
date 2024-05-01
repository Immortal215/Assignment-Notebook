import SwiftUI

struct Homepage: View {
    @State var settings = false
    var body: some View {
        TabView(selection: .constant(1),
                content:  {
            Notebook().tabItem {Text("Assignment Notebook")}.tag(1)
            Settinger().tabItem {Text("Settings")}.tag(2).onTapGesture {
               settings = true 
            }
        })
    }
}
