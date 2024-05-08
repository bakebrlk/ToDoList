//
//  TaskData.swift
//  Taskly
//
//  Created by bakebrlk on 08.04.2024.
//

import Foundation
import SwiftUI

@MainActor
final class TaskData: ObservableObject {
       
    private var user: UserModel?
    
    @ObservedObject var taskGroup = Data.Tasks()
    
    public func setTaskGroup(_ group: Data.Tasks ) {
        taskGroup = group
    }
    
    public func setUser(user: UserModel){
        self.user = user
    }
        
    @Published public var Task: [TaskModel] = []
    

    public func appendTasks(userID: String) async throws {
        print("append Task")
        let tasks = try await FirebaseFunction.getTask(userID: userID)

        Task = tasks
        
        for group in taskGroup.TaskGroup {
            taskGroup.statistics(group: group)
        }
    }
    
    public func getTasks() -> [TaskModel] {
        return Task
    }
    
    public func offSet(index: Int, _ offSet: CGFloat){
        if index < Task.count {
            Task[index].offSet = offSet
        }
    }
    public func offSet(task: TaskModel, _ offSet: CGFloat){
        for index in 0..<Task.count {
            if Task[index].id == task.id {
                withAnimation{
                    Task[index].offSet = offSet
                }
                break
            }
        }
    }
    
    public func isSwipe(task: TaskModel ,_ value: Bool) {
        for index in 0..<Task.count {
            if Task[index].id == task.id {
                Task[index].isSwiped = value
                break
            }
        }
    }
    
    public func updateData(task: TaskModel, title: String?, description: String?){
        
        for i in 0..<Task.count {
            if Task[i].id == task.id{
                
                if let title = title, let description = description{
                    Task[i].title = title
                    Task[i].description = description
                    
                    FirebaseFunction.updateTask(userId: user!.id, taskID: Task[i].id, title: title, description: description, status: nil)
                    
                }else if let title = title {
                    Task[i].title = title
                    FirebaseFunction.updateTask(userId: user!.id, taskID: Task[i].id, title: title, description: nil, status: nil)
                    
                }else if let description = description{
                    print("\(description)")
                    Task[i].description = description
                    FirebaseFunction.updateTask(userId: user!.id, taskID: Task[i].id, title: nil, description: description, status: nil)
                    
                }
                
                break
            }
        }
        
    }
    
    public func updateStatus(task: TaskModel, status: TaskStatus) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            if let index = self.Task.firstIndex(where: { $0.id == task.id }) {
                self.Task[index].status = status
                FirebaseFunction.updateTask(userId: user!.id, taskID: task.id, title: nil, description: nil, status: status)
            }
        }
        offSet(task: task, 0)
    }
    
    public func deleteTask(task: TaskModel) async throws{
        
        guard let user = user else{
            return
        }
        for i in 0..<Task.count {
            if Task[i].id == task.id{
                withAnimation{
                    Task.remove(at: i)
                }
                break
            }
        }
        try await FirebaseFunction.deleteTask(userId:user.id, taskID: task.id)
    }
    
//MARK: Statistic
    
    public func todayStatistic() -> Double{
        var doneTasks = 0.0
        var allTasks = 0.0
        
        for task in Task{
            if Calendar.current.isDate(task.time, equalTo: Calendar.current.date(byAdding: .day, value: 0, to: Date())!, toGranularity: .day) {
                
                if task.status == .done {
                    doneTasks += 1.0
                }
                allTasks += 1.0
            }
        }
        return (doneTasks/allTasks).isNaN ? 0.0 : doneTasks/allTasks
    }
    
//MARK: get inProgress tasks
    public func getInProgressTasks() -> [inProgressModel]{
        var tasks: [inProgressModel] = []
        
        for task in Task {
            if task.status == .inProcess {
                tasks.append(inProgressModel(group: task.taskGroup.title, title: task.title, logo: task.taskGroup.img, color: task.taskGroup.color, progress: task.taskGroup.process))
            }
        }
        return tasks
    }
    
    
}


