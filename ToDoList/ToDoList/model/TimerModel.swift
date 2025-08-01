//
//  TimerModel.swift
//  ToDoList
//
//  Created by bakebrlk on 14.03.2024.
//

import SwiftUI

enum TimerEnum {
    case start
    case stop
    case pause
    case def
    
    func imageName(caseV: TimerEnum) -> String {
        switch caseV {
            
        case .start:
            "play.circle.fill"
        case .stop:
            "stop.circle.fill"
        case .pause:
            "pause.circle.fill"
        case .def:
            ""
        }
    }
}

class TimerModel: NSObject, ObservableObject{
    
    @Binding private var timerTotalSecond: Double
    @Binding private var processTimer: Double
    @Binding private var timerFullSecond: Double
    
    @Binding private var timerMonitoring: TimerEnum
    
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    init(timerTotalSecond: Binding<Double>, process: Binding<Double>, val: Binding<Double>, timerMonitoring: Binding<TimerEnum>) {
        _timerTotalSecond = timerTotalSecond
        _processTimer = process
        _timerFullSecond = val
        _timerMonitoring = timerMonitoring
    }
    
    public func TimerViewModel(width: CGFloat, height: CGFloat) -> some View {
        ZStack{
            
            CircleModel(process: $processTimer, textSize: -1, textColor: Color("purple"), colors: [Color("purple"), .blue, .cyan]).statisticsCircles(width: width, height: height)
                .onReceive(timer) { [self] _ in
                    
                    if timerMonitoring == .start{
                        
                        if timerTotalSecond > 0 {
                            withAnimation{
                                timerTotalSecond -= 1
                                processTimer = Double(timerTotalSecond/timerFullSecond)
                            }
                        }else{

                            addNotification()
                            timerFullSecond = 0
                            processTimer = 1.0
                            timerMonitoring = .def
                        }
                        
                    }
                }
            
            textView(text: "\(SecondFormatter(totalSecond: timerTotalSecond))", size: 30)
                .padding()
                .background(Color("purple"))
                .foregroundColor(.white)
                .cornerRadius(20)
        }
        .onAppear{
            self.authorizeNotification()
        }
    }
    
    private func SecondFormatter(totalSecond: Double) -> String{
        let hour = Int(totalSecond/3600)
        let minute = Int(totalSecond.truncatingRemainder(dividingBy: 3600))/60
        let second = Int(totalSecond.truncatingRemainder(dividingBy: 60))
        
        var res = hour < 10 ? "0\(hour) : " : "\(hour) : "
        res.append(minute < 10 ? "0\(minute) : " : "\(minute) : ")
        res.append(second < 10 ? "0\(second)" : "\(second)")
        
        return res
        
    }
}
extension TimerModel: UNUserNotificationCenterDelegate{
    

    
    func authorizeNotification(){
        UNUserNotificationCenter.current().requestAuthorization(options: [.sound, .alert, .badge]) {_,_ in }
        
        UNUserNotificationCenter.current().delegate = self
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.sound,.banner])
    }
    
    private func addNotification(){
        let content = UNMutableNotificationContent()
        content.title = "Taskly Timer"
        content.subtitle = "Timer is up !!!"
        content.sound = UNNotificationSound.default
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(0.1), repeats: false) )

        UNUserNotificationCenter.current().add(request)
    }
}
