import SwiftUI

struct Pomo: View {
    @AppStorage("pomotimer") var pomoTime = 1500
    @AppStorage("breakTime") var breakTime = 300
    @AppStorage("breaks") var breaks = 4 
    @AppStorage("pomoOpened") var pomoOpened = false 
    @AppStorage("opened") var opened = false
    @AppStorage("currentBreaks") var currentBreaks = 0 
    @AppStorage("breakText") var breakText = false  
    @State var currentColor: Color = .pink
  
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
                                    timer.invalidate()
                                    myTimer?.invalidate()
                                    myTimer = timer
                                    
                                } label: {
                                    RoundedRectangle(cornerRadius: 20)
                                        .foregroundStyle(.green)
                                        .opacity(0.6)
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
                                        .opacity(0.6)
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
                                    .opacity(0.6)
                                
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
                        Text("Pomodoro Timer")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        Divider()
                        Spacer() 
              
                            ZStack {
                                
                                Circle()
                                    .stroke(lineWidth: 20)
                                    .opacity(0.3)
                                    .foregroundColor(.gray)
                                
                                Circle()
                                    .trim(from: 0.0, to: CGFloat(breakText ? Double(progressTimePomo/breakTime) : Double(progressTimePomo/(pomoTime == 0 ? progressTimePomo : pomoTime))))
                                    .stroke(style: StrokeStyle(lineWidth: 20, lineCap: .round, lineJoin: .round))
                                    .rotationEffect(Angle(degrees: 270.0))
                                    .animation(.linear(duration:  (progressTimePomo == pomoTime ? 0.0 : (breakText ? Double(breakTime) : (progressTimePomo > 1 ? Double(progressTimePomo) : 0.0)))), value: progressTimePomo)
                                    .foregroundStyle(currentColor)
                                    .opacity(0.3)
                                    .onChange(of: breakText) { i in
                                        currentColor = i ? .green : .pink
                                    }
                                
                                
                                VStack {
                                    
                                    Text("\(minutesPomo):\(secondsPomo)")
                                        .font(.system(size: 100))
                                        .foregroundStyle(currentColor)
                                        .opacity(0.5)
                                        .padding(-100)
                                    Divider()
                                        .frame(width: 200)
                                    Text("\(breakText ? "Pomo" : "Break") Time : \(breakText ? (pomoTime > 60 ? pomoTime/60 : pomoTime) : (breakTime/60)) \(pomoTime > 60 ? "Minutes" : breakText ?  "Seconds" : "Minutes")")
                                        .font(.system(size: 25))
                                    Text(currentBreaks > 0 ? "Breaks taken : \(currentBreaks)" : "")
                                        .font(.system(size:20))
                                    
                                    
                                }
                                .offset(y: 50)
                            }
                            .frame(width:325, height: 325)
                        
                        //  .padding(40)
                        
                        //   Divider()
                        //         .frame(width:300)
                        Spacer()
                        VStack { 
                            HStack {
                                Button {
                                    timerPomo.invalidate()
                                    myTimerPomo?.invalidate()
                                    myTimerPomo = timerPomo
                                    
                                    print(pomoTime/progressTimePomo)
                                } label: {
                                    RoundedRectangle(cornerRadius: 20)
                                        .foregroundStyle(.green)
                                        .opacity(0.6)
                                    
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
                                        .opacity(0.6)
                                    
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
                                    .opacity(0.6)
                                
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
