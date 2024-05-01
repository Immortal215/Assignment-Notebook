import SwiftUI

struct Start: View {
    var body: some View {
        NavigationStack {
            Text("The Drawing Board")
                .font(Font.custom("SF Mono", fixedSize: 100))
            Divider()
            NavigationLink(destination: Homepage()) { 
                Text("Start")
                    .font(.largeTitle)
            }
        }
        
        
    }
}
