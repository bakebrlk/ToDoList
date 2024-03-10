//
//  CalendarView.swift
//  ToDoList
//
//  Created by bakebrlk on 06.03.2024.
//

import SwiftUI

struct CalendarPageView: View {
    
    @State private var selectDate = 0
    
    private let taskStatus = [
                            TaskStatus.all,
                            TaskStatus.toDo,
                            TaskStatus.inProcess,
                            TaskStatus.done]

    @State private var taskStatusState: TaskStatus = .all
    @State private var selectColor:Color = .purple

    
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
                ForEach(-15..<16, id: \.self) { id in
                    let date: Date = Calendar.current.date(byAdding: .day, value: id, to: Date()) ?? Date()
                    Button(action: {
                        selectDate = id
                    }, label: {
                        CalendarModel.shared.forCalendarPage(date: date)
                    })
                    .foregroundColor(selectDate == id ? .white: .black)
                    .background(selectDate == id ? Color("purple") : .white)
                    .cornerRadius(16)
                    
                }
            }
            .padding(5)
        }
        .defaultScrollAnchor(.center)
    }
    
//MARK: Status Task
    private func statusTask() -> some View {
        ScrollView(.horizontal,showsIndicators: false){
            HStack{
                ForEach(taskStatus, id: \.self){ id in
                    statusTaskView(status: id)
                }
            }
            .padding(.leading)
        }
        .frame(maxWidth: .infinity)
    }
    
    private func statusTaskView(status: TaskStatus) -> some View {
        Button(action: {
            print(status)
            taskStatusState = status
        }, label: {
            textView(text: status.builder, size: 16)
                .padding([.leading,.trailing],20)
                .padding([.top,.bottom],10)
                .foregroundColor(taskStatusState == status ? .white : Color("purple"))
        })
        .background(Color("purple").opacity(taskStatusState == status ? 1 : 0.1))
        .cornerRadius(16)
        .padding(5)
    }
    
//MARK: Status Result
    private func statusResult() -> some View {
        ScrollView(.vertical, showsIndicators: false){
            ForEach(Data.Tasks.Task){ task in
                if taskStatusState != .all{
                    if task.status == taskStatusState {
                        TaskModel.TaskModel(model: task)
                    }
                }else{
                    TaskModel.TaskModel(model: task)
                }
            }
        }
    }
}

#Preview {
    CalendarPageView()
}
