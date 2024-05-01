import SwiftUI

struct Start: View {
    @State var starter = true 
    var body: some View {
        NavigationStack {
            Button {
               starter = false  
            } label : {
                Text("The Drawing Board")
                    .font(.custom("", fixedSize: 100))
                    .foregroundStyle(.white)
            }
                
                    Divider()
                    NavigationLink(destination: Homepage()) { 
                        Text("Start Planning")
                            .font(.custom("", fixedSize: 50))
                            .frame(width: starter ? 0 : .infinity, height: starter ? 0 : 100, alignment:.center)
                        
                    
                
            }
                    .frame(width: starter ? 0 : .infinity, height: starter ? 0 : 100, alignment:.center)
            
            
                
                
                    
            
            }
        
        
        
    }
}
