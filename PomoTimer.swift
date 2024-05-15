import SwiftUI

struct Pomo: View {
    @AppStorage("pomotimer") var pomoTime = 1500
    @AppStorage("breakTime") var breakTime = 300
    @AppStorage("breaks") var breaks = 4 
    @AppStorage("pomoOpened") var pomoOpened = false 
    @AppStorage("opened") var opened = false
    
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
    
    @AppStorage("progressTime") var progressTime = 0
    @State var myTimer:Timer?
    
    var timerPomo: Timer {
        //MARK: Stretch #3 - Part I
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) {_ in
            progressTimePomo -= 1
        }
    }
    
    var minutesPomo: String {
        //MARK: Stretch #3 - Part II
        let time = (progressTimePomo % 3600) / 60
        return time < 10 ? "0\(time)" : "\(time)"
    }
    
    var secondsPomo: String {
        //MARK: Stretch #3 - Part III
        let time = progressTimePomo % 60
        return time < 10 ? "0\(time)" : "\(time)"
    }
    
    @AppStorage("progressPomo") var progressTimePomo = 0
    @State var myTimerPomo:Timer?
    
    
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
                        
                        VStack {
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
                            Button {
                                progressTime = 0 
                                myTimer?.invalidate()
                            } label: {
                                RoundedRectangle(cornerRadius: 20)
                                    .foregroundStyle(.blue)
                                    .opacity(0.3)
                                    .animation(.bouncy(duration: 1, extraBounce: 0.1))
                                    .overlay(
                                        Text("Reset")
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
                        
                        Text("\(minutesPomo):\(secondsPomo)")
                            .font(.system(size: 100))
                        
                        VStack { 
                            HStack {
                                Button {
                                    myTimerPomo = timerPomo
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
                                    myTimerPomo?.invalidate()
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
                            Button {
                                progressTimePomo = pomoTime
                                myTimerPomo?.invalidate()
                            } label: {
                                RoundedRectangle(cornerRadius: 20)
                                    .foregroundStyle(.blue)
                                    .opacity(0.3)
                                    .animation(.bouncy(duration: 1, extraBounce: 0.1))
                                    .overlay(
                                        Text("Reset")
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
        .onAppear {
            if pomoOpened == false {
                progressTimePomo = pomoTime
                pomoOpened = true 
            } 
            
            progressTimePomo = progressTimePomo
            
            if opened == false {
                progressTime = 0 
                opened = true 
            }   
            progressTime = progressTime
            
            
           
        }
        .onChange(of: pomoTime) {
            myTimerPomo?.invalidate()
        }
    }
}
