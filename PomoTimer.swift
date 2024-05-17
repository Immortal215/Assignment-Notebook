import SwiftUI

struct Pomo: View {
    @AppStorage("pomotimer") var pomoTime = 1500
    @AppStorage("breakTime") var breakTime = 300
    @AppStorage("breaks") var breaks = 4 
    @AppStorage("pomoOpened") var pomoOpened = false 
    @AppStorage("opened") var opened = false
    @AppStorage("currentBreaks") var currentBreaks = 0 
    @AppStorage("breakText") var breakText = false  
    
    var timer: Timer {
       
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) {_ in
            progressTime += 1
        }
    }
    
    var minutes: String {
    
        let time = (progressTime % 3600) / 60
        return time < 10 ? "0\(time)" : "\(time)"
    }
    
    var seconds: String {
    
        let time = progressTime % 60
        return time < 10 ? "0\(time)" : "\(time)"
    }
    
    @AppStorage("progressTime") var progressTime = 0
    @State var myTimer:Timer?
    
    var timerPomo: Timer {
   
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) {_ in
            if progressTimePomo > 0 {
                progressTimePomo -= 1
            } else {
                progressTimePomo = breakTime
                currentBreaks += 1
                breakText = true
            }
        }
    }
    
    var minutesPomo: String {
  
        let time = (progressTimePomo % 3600) / 60
        return time < 10 ? "0\(time)" : "\(time)"
    }
    
    var secondsPomo: String {
     
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
                                        .opacity(0.7)
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
                                        .opacity(0.7)
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
                                    .opacity(0.7)
                           
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
                        Text("\(breakText ? "Pomo" : "Break") Time : \(breakText ? (pomoTime > 60 ? pomoTime/60 : pomoTime) : (breakTime/60)) \(pomoTime > 60 ? "Minutes" : breakText ?  "Seconds" : "Minutes")")
                            .font(.system(size: 25))
                        Text(currentBreaks > 0 ? "Breaks taken : \(currentBreaks)" : "")
                            .font(.system(size:20))
           
                        
                        Divider()
                            .frame(width:300)
                        
                        VStack { 
                            HStack {
                                Button {
                                    myTimerPomo = timerPomo
                                } label: {
                                    RoundedRectangle(cornerRadius: 20)
                                        .foregroundStyle(.green)
                                        .opacity(0.7)
                          
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
                                        .opacity(0.7)
                                 
                                        .overlay(
                                            Text("Stop")
                                                .font(.custom("", fixedSize: 50))
                                                .foregroundStyle(.white)
                                        )
                                        .frame(width:200, height:100)
                                }
                            }
                            Button {
                                myTimerPomo?.invalidate()
                                progressTimePomo = pomoTime
                                breaks = 0 
                                breakText = false 
                                currentBreaks = 0 
                            } label: {
                                RoundedRectangle(cornerRadius: 20)
                                    .foregroundStyle(.blue)
                                    .opacity(0.7)
                                
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
                .animation(.snappy(duration: 0.3, extraBounce: 0.3))
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
