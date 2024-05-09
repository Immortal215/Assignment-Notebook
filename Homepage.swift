import SwiftUI

struct Homepage: View {
    @State var screenWidth = UIScreen.main.bounds.width
    @State var screenHeight = UIScreen.main.bounds.height
    
    var body: some View {
        ZStack {
            
              
            VStack {
                Text("Home")
                    .font(Font.custom("SF Compact Rounded", fixedSize: (screenWidth/25)))
                    .fontWeight(.bold)    
                
                Divider()
                
                Text("Most Urgent!")
                    .font(Font.custom("SF Compact Rounded", fixedSize: (screenWidth/25)))
                    .frame(width: screenWidth, height: 100, alignment: .center)
                Divider()
                    .frame(width: 400)
                
            }
           
        }
    }
}
