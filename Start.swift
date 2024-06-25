import SwiftUI

struct Start: View {
    @State var starter = true
    var body: some View {
        NavigationStack {
            Button {
                starter = false
            } label: {
                ZStack {
                    Image(systemName: "square.and.pencil")
                        .resizable()
                        .frame(width: 200, height: 200)
                        .rotationEffect(.degrees(starter ? 0.0 : 15.0))
                     //   .scaleEffect(starter ? 2.0 : 1.0)
                        .animation(starter ? .easeIn(duration: 0) : .bouncy(duration: 1, extraBounce: 0.3) )
                        
                    Text("The Drawing Board")
                        .font(.custom("", fixedSize: 100))
                        .foregroundStyle(.white)
                        .shadow(color: .gray, radius: 5, x: 0.0, y: 0.0)
                    
                }
                
            }
            
            Divider()
                .frame(width: starter ? 0 : .infinity)
            NavigationLink(destination: ContentView()) {
                
                RoundedRectangle(cornerRadius: 20)
                    .foregroundStyle(.blue)
                    .opacity(0.3)
                
                    .offset(x: 0, y: starter ? -100 : 0)
                
                    .animation(.bouncy(duration: 1, extraBounce: 0.1))
                    .overlay(
                        Text("Start Planning")
                            .font(.custom("", fixedSize: 50))
                            .foregroundStyle(.white)
                            .frame(width: starter ? 0 : 500, height: starter ? 0 : 100, alignment: .center)
                            .offset(x: 0, y: starter ? -100 : 0)
                            .animation(.bouncy(duration: 1, extraBounce: 0.1))
                    )
                
            }
            .frame(width: starter ? 0 : 500, height: starter ? 0 : 100, alignment: .center)
            .padding(starter ? 0 : 20)
        

        }
    }
}
