import SwiftUI

struct Pomo: View {
    
    var timer: Timer {
        //MARK: Stretch #3 - Part I
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) {_ in
            progressTime += 1
        }
    }
    
    var minutes: String {
        //MARK: Stretch #3 - Part II
        let time = (progressTime % 3600) / 60
        return time < 10 ? "0\(time)" : "\(time)"
    }
    
    var seconds: String {
        //MARK: Stretch #3 - Part III
        let time = progressTime % 60
        return time < 10 ? "0\(time)" : "\(time)"
    }
    
    @State private var progressTime = 0
    @State var myTimer:Timer?
    
    var body: some View {
        ZStack {
            NavigationStack {
                HStack {
                    VStack {
                        Text("Stop Watch")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        Divider()
                        Text("\(minutes):\(seconds)")
                            .font(.system(size: 100))
                        HStack {
                            Button {
                                myTimer = timer
                            } label: {
                                RoundedRectangle(cornerRadius: 20)
                                    .foregroundStyle(.green)
                                    .opacity(0.3)
                                    .animation(.bouncy(duration: 1, extraBounce: 0.1))
                                    .overlay(
                                        Text("Start")
                                            .font(.custom("", fixedSize: 50))
                                            .foregroundStyle(.white)
                                            .animation(.bouncy(duration: 1, extraBounce: 0.1))
                                    )
                                    .frame(width:200, height:100)

                                
                            }
                            Button {
                                myTimer?.invalidate()
                            } label: {
                                RoundedRectangle(cornerRadius: 20)
                                    .foregroundStyle(.red)
                                    .opacity(0.3)
                                    .animation(.bouncy(duration: 1, extraBounce: 0.1))
                                    .overlay(
                                        Text("Stop")
                                            .font(.custom("", fixedSize: 50))
                                            .foregroundStyle(.white)
                                    )
                                    .frame(width:200, height:100)
                                   
                            }
                        }
                    }
                    Divider()
                    VStack {
                        Text("Pomo Timer")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        Divider()
                        Text("20:00")
                            .font(.system(size: 100))
                        HStack {
                            Button {
                             
                            } label: {
                                RoundedRectangle(cornerRadius: 20)
                                    .foregroundStyle(.green)
                                    .opacity(0.3)
                                    .animation(.bouncy(duration: 1, extraBounce: 0.1))
                                    .overlay(
                                        Text("Start")
                                            .font(.custom("", fixedSize: 50))
                                            .foregroundStyle(.white)
                                            .animation(.bouncy(duration: 1, extraBounce: 0.1))
                                    )
                                    .frame(width:200, height:100)
                                
                            }
                            Button {
                                
                            } label: {
                                RoundedRectangle(cornerRadius: 20)
                                    .foregroundStyle(.red)
                                    .opacity(0.3)
                                    .animation(.bouncy(duration: 1, extraBounce: 0.1))
                                    .overlay(
                                        Text("Stop")
                                            .font(.custom("", fixedSize: 50))
                                            .foregroundStyle(.white)
                                    )
                                    .frame(width:200, height:100)
                            }
                        }
                    }
                }
            }
        }
    }
}
