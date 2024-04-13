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
    
    public func setUser(user: UserModel){
        self.user = user
    }
    
    @Published public var Task: [TaskModel] = [
        TaskModel(id: "E621E1F8-C36C-495A-93FC-0C247A3E6E5F", title: "Market Research", description: "Grocery shopping app design", status: .done, time: Date(), taskGroup: Data.Tasks.TaskGroup[0]),
        TaskModel(id: "E721E1F8-C36C-495A-93FC-0C247A3E6E5F", title: "Market Research", description: "Grocery shopping app design", status: .inProcess, time: Date(), taskGroup: Data.Tasks.TaskGroup[1]),
        TaskModel(id: "E821E1F8-C36C-495A-93FC-0C247A3E6E5F", title: "Market Research", description: "Grocery shopping app design", status: .toDo, time: Date(), taskGroup: Data.Tasks.TaskGroup[2]),
        TaskModel(id: "E921E1F8-C36C-495A-93FC-0C247A3E6E5F", title: "Market Research", description: "Grocery shopping app design", status: .done, time: Date(), taskGroup: Data.Tasks.TaskGroup[3]),
        TaskModel(id: "E121E1F8-C36C-495A-93FC-0C247A3E6E5F", title: "Market Research", description: "Grocery shopping app design", status: .inProcess, time: Date(), taskGroup: Data.Tasks.TaskGroup[4])
    ]
    
    public func appendTasks(userID: String) async throws {
        let tasks = try await FirebaseFunction.getTask(userID: userID)

        for task in tasks {
            Task.append(task)
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
                Task[index].offSet = offSet
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
                    
                    FirebaseFunction.updateTask(userId: user!.id, taskID: Task[i].id, title: title, description: description, status: Task[i].status)
                    
                }else if let title = title {
                    Task[i].title = title
                    FirebaseFunction.updateTask(userId: user!.id, taskID: Task[i].id, title: title, description: Task[i].description, status: Task[i].status)
                    
                }else if let description = description{
                    Task[i].description = description
                    FirebaseFunction.updateTask(userId: user!.id, taskID: Task[i].id, title: Task[i].title, description: description, status: Task[i].status)
                    
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
            }
        }
    }
    
}


