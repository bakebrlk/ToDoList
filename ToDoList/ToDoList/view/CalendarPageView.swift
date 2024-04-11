//
//  CalendarView.swift
//  ToDoList
//
//  Created by bakebrlk on 06.03.2024.
//

import SwiftUI

struct CalendarPageView: View {
    
    @State private var selectDate = 0
    
    @EnvironmentObject var navigate: Navigation
    
    @State private var listIsEmpty = false
    
    @State private var showEditTask: Bool = false
    
    @ObservedObject var viewModel = editTaskView.ViewModel()

    private let taskStatus = [
                            TaskStatus.all,
                            TaskStatus.toDo,
                            TaskStatus.inProcess,
                            TaskStatus.done]

    @State private var taskStatusState: TaskStatus = .all
    @State private var selectColor:Color = .purple

    @StateObject var db = TaskData.db
    
//MARK: Body
    var body: some View {
        VStack{
            navigationBar
            
            calendar()
            
            statusTask()
            
            statusResult()
        }
        .frame(maxWidth: .infinity,maxHeight: .infinity)
        .background(BackgroundMode().viewBack())
        .environment(\.colorScheme, BackgroundMode().isDark ? .dark : .light)
        .onAppear {
            listIsEmpty = db.Task.isEmpty
        }
        .sheet(isPresented: $showEditTask, content: {
            editTaskView(task: viewModel.getTask(), showEditTask: $showEditTask, db: db)
                .presentationDetents([.height(Size.size[1]/2.1)])
        })
    }
}

extension CalendarPageView {
    
//MARK: TOP Navigation BAR
    private var navigationBar: some View {
        NavigationBar().NavigationTopBar(title: "Today's Task", navigateTo: navigateChat)
    }
    
    private func navigateChat(){
        navigate.navigateTo(.chat)
    }
    
//MARK: Calendar
    private func calendar() -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack{
                ForEach(-15..<16, id: \.self) { id in
                    let date: Date = Calendar.current.date(byAdding: .day, value: id, to: Date()) ?? Date()
                    Button(action: {
                        selectDate = id
                        listIsEmpty = checkSelectedDate()
                        print(listIsEmpty)
                    }, label: {
                        CalendarModel.shared.forCalendarPage(date: date)
                    })
                    .foregroundColor(.black)
                    .background(selectDate == id ?  BackgroundMode().avtorColor() : .white.opacity(BackgroundMode().isDark ? 0.92 : 0))
                    .cornerRadius(16)
                    
                }
            }
            .padding(5)
        }
        .defaultScrollAnchor(.center)
    }
    
    private func checkSelectedDate() -> Bool {
        
        var result = true
        for date in db.Task{
            if Calendar.current.isDate(date.time, equalTo:  Calendar.current.date(byAdding: .day, value: selectDate, to: Date())! , toGranularity: .day){
                
                result = false
                break
            }
        }
        return result
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
            taskStatusState = status
        }, label: {
            textView(text: status.builder, size: 16)
                .padding([.leading,.trailing],20)
                .padding([.top,.bottom],10)
                .foregroundColor(taskStatusState != status ? .white : BackgroundMode().isDark ? Color("purple") : .yellow )
        })
        .background( BackgroundMode().avtorColor().opacity(taskStatusState == status ? 1 : 0.5))
        .cornerRadius(16)
        .padding(5)
    }
    
//MARK: Status Result
    private func statusResult() -> some View {
        ZStack{
            if listIsEmpty {
                VStack{
                    Spacer()
                    Image("listEmpty")
                        .frame(maxWidth: Size.size[1]/1.5)
                    textView(text: "List is Empty", size: 24)
                        .foregroundStyle(BackgroundMode().textColor())
                    Spacer()
                }
            } else {
                ScrollView(.vertical, showsIndicators: false) {
                    ForEach(db.Task) { task in
//                        let task = db.Task[index]
                        
                        if Calendar.current.isDate(task.time, equalTo: Calendar.current.date(byAdding: .day, value: selectDate, to: Date())!, toGranularity: .day) {
                            
                            if taskStatusState == .all {
                                
                                        Button(action: {
                                            viewModel.setTask(task: task)
                                            showEditTask.toggle()
                                            print("\(taskStatusState) \(task.status)")
                                        }) {
                                            TaskModel.TaskModel(model: task)
                                        }
                                    
                                
                            }else{
                                
                                if taskStatusState != .all && task.status == taskStatusState {
                                    TaskModel.TaskModel(model: task)
                                        .onTapGesture {
                                            viewModel.setTask(task: task)
                                            showEditTask.toggle()
                                            print(task.status)
                                        }
                                    
                                }
                            }
                           
                                
                            
                        }
                    }
                }
            }
        }
        
    }

}

#Preview {
    CalendarPageView()
}
