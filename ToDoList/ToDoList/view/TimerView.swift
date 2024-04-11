//
//  TimerView.swift
//  ToDoList
//
//  Created by bakebrlk on 14.03.2024.
//

import SwiftUI

struct TimerView: View {
    
    @State private var monitoringSecond: Double = 60.0
    @State private var process = 1.0
    @State private var totalSecond = 60.0
    
    @State private var timerMonitoring: TimerEnum = .def
    @EnvironmentObject var navigate: Navigation

//MARK: Body
    var body: some View {
        
        VStack{
            
            NavigationBar().NavigationTopBar(title: "Timer", navigateTo: navigateChat)
            
            Spacer()
            
            timer
            
            HStack {
                ZStack{
                    if timerMonitoring == .start {
                        timerBtn(nameImage: timerMonitoring.imageName(caseV: .pause), action: pause)
                    }else{
                        timerBtn(nameImage: timerMonitoring.imageName(caseV: .start), action: play)
                    }
                }
                timerBtn(nameImage: timerMonitoring.imageName(caseV: .stop), action: stop)
            }
            
            HStack{
                addTime(second: 3600.0, text: "+1h")
                addTime(second: 60.0, text: "+1m")
                addTime(second: 10.0, text: "+10s")
            }
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(BackgroundMode().viewBack())
        .environment(\.colorScheme, BackgroundMode().isDark ? .dark : .light)
        
    }
    
}

extension TimerView {
    
    private func navigateChat(){
        navigate.navigateTo(.chat)
    }
    
//MARK: Timer
    private var timer: some View {
        TimerModel(timerTotalSecond: $monitoringSecond, process: $process, val: $totalSecond, timerMonitoring: $timerMonitoring).TimerViewModel(width: Size.size[0]*0.7, height: Size.size[1]*0.4)
          
    }
    
//MARK: Timer Btn
    private func timerBtn(nameImage: String, action: @escaping () -> Void) -> some
    View {
        Button(action: {
            action()
        }, label: {
            
            Image(systemName: nameImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundColor(Color(.purple))
                
        })
        .frame(maxWidth: Size.size[0]/7, maxHeight: Size.size[1]/10)
        .padding([.leading, .trailing])
    }
    
//MARK: Play Action
    private func play(){
        if totalSecond != 0{
            timerMonitoring = .start
        }
    }
    
//MARK: Stop Action
    private func stop(){
        timerMonitoring = .stop
        
        withAnimation{
            monitoringSecond = 0
            totalSecond = 0
            process = 1.0
        }
    }
    
//MARK: Pause Action
    private func pause() {
        timerMonitoring = .pause
    }
    
//MARK: Add time
    private func addTime(second: Double, text: String) -> some View {
        Button(action: {
            
            totalSecond += second
            monitoringSecond += second
            
            withAnimation{
                process = monitoringSecond/totalSecond
            }
            
        }, label: {
            textView(text: text, size: 16)
                .foregroundColor(.white)
                .padding()
        })
        .background(Color("purple"))
        .cornerRadius(20)
        .padding([.leading, .top])
    }
}
#Preview {
    TimerView()
}
