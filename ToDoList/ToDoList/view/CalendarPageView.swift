//
//  CalendarView.swift
//  ToDoList
//
//  Created by bakebrlk on 06.03.2024.
//

import SwiftUI

struct CalendarPageView: View {
    
    private let taskStatus = ["All","To do", "In Progress", "Done"]

    @State private var taskStatusId = 0
    
//MARK: Body
    var body: some View {
        VStack{
            navigationBar
            
            calendar()
            
            statusTask()
            
            statusResult()
        }
        .frame(maxWidth: .infinity,maxHeight: .infinity)
        .background(Color.cyan.opacity(0.1))
    }
}

extension CalendarPageView {
    
//MARK: TOP Navigation BAR
    private var navigationBar: some View {
        NavigationTopBar(title: "Today's Task", backAction: backAction())
    }
    
    private func backAction(){
        
    }
    
//MARK: Calendar
    private func calendar() -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack{
                ForEach(0..<31) { date in
                    let date = Calendar.current.date(byAdding: .day, value: date, to: Date()) ?? Date()
                    CalendarModel.shared.forCalendarPage(date: date)
                }
            }
            .padding(5)
        }
    }
    
//MARK: Status Task
    private func statusTask() -> some View {
        ScrollView(.horizontal,showsIndicators: false){
            HStack{
                ForEach(0..<taskStatus.count, id: \.self){ id in
                   statusTaskView(id: id)
                }
            }
            .padding(.leading)
        }
        .frame(maxWidth: .infinity)
    }
    
    private func statusTaskView(id: Int) -> some View {
        Button(action: {
            taskStatusId = id
        }, label: {
            textView(text: taskStatus[id], size: 16)
                .padding([.leading,.trailing],20)
                .padding([.top,.bottom],10)
                .foregroundColor(taskStatusId == id ? .white : Color("purple"))
        })
        .background(Color("purple").opacity(taskStatusId == id ? 1 : 0.1))
        .cornerRadius(16)
        .padding(5)
    }
    
//MARK: Status Result
    private func statusResult() -> some View {
        ScrollView(.vertical, showsIndicators: false){
            ForEach(Data.Tasks.Task){ task in
                TaskModel.TaskModel(model: task)
            }
        }
    }
}

#Preview {
    CalendarPageView()
}
