//
//  TaskData.swift
//  Taskly
//
//  Created by bakebrlk on 08.04.2024.
//

import Foundation
import SwiftUI

final class TaskData: ObservableObject {
        
     @Published var Task = [
        TaskModel(id: "E621E1F8-C36C-495A-93FC-0C247A3E6E5F", title: "Market Research", description: "Grocery shopping app design", status: .done, time: Date(), taskGroup: Data.Tasks.TaskGroup[0]),
        TaskModel(id: "E721E1F8-C36C-495A-93FC-0C247A3E6E5F", title: "Market Research", description: "Grocery shopping app design", status: .inProcess, time: Date(), taskGroup: Data.Tasks.TaskGroup[1]),
        TaskModel(id: "E821E1F8-C36C-495A-93FC-0C247A3E6E5F", title: "Market Research", description: "Grocery shopping app design", status: .toDo, time: Date(), taskGroup: Data.Tasks.TaskGroup[2]),
        TaskModel(id: "E921E1F8-C36C-495A-93FC-0C247A3E6E5F", title: "Market Research", description: "Grocery shopping app design", status: .done, time: Date(), taskGroup: Data.Tasks.TaskGroup[3]),
        TaskModel(id: "E121E1F8-C36C-495A-93FC-0C247A3E6E5F", title: "Market Research", description: "Grocery shopping app design", status: .inProcess, time: Date(), taskGroup: Data.Tasks.TaskGroup[4])
    ]
    
    public func appendTask(model: TaskModel) {
        DispatchQueue.main.async {
            self.Task.append(model)
        }
    }
    
    public func updateStatus(task: TaskModel, status: TaskStatus) async throws{
        await MainActor.run {
            do{
                for i in 0..<Task.count {
                    if Task[i].id == task.id{
                        Task[i].status = status
                        
                    }
                }
            }
        }
       
        
    }
}


