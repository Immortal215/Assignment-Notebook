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
                .frame(width: starter ? 0 : .infinity)
            NavigationLink(destination: Homepage()) { 
                
             
                    RoundedRectangle(cornerRadius: 20)
                        .foregroundStyle(.blue)
                        .opacity(0.3)
                      
                          .offset(x: 0, y: starter ? -100 : 0)
                  
                          .animation(.bouncy(duration: 1, extraBounce: 0.1))
                          .overlay(
                            Text("Start Planning")
                                .font(.custom("", fixedSize: 50))
                                .foregroundStyle(.white)
                                .frame(width: starter ? 0 : 500, height: starter ? 0 : 100, alignment:.center)
                                .offset(x: 0, y: starter ? -100 : 0)
                                 .animation(.bouncy(duration: 1, extraBounce: 0.1))
                          )   
                    
                
            }
            .frame(width: starter ? 0 : 500, height: starter ? 0 : 100, alignment:.center)
            
            
            
            
            
            
            
        }
     
        
    }
}
