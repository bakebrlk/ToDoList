//
//  TaskData.swift
//  Taskly
//
//  Created by bakebrlk on 08.04.2024.
//

import Foundation
import SwiftUI

final class TaskData: ObservableObject {
    
  
    
    static var db = TaskData()
        
    @Published var Task = [
        TaskModel(id: UUID(uuidString: "E621E1F8-C36C-495A-93FC-0C247A3E6E5F")!, title: "Market Research", description: "Grocery shopping app design", status: .done, time: Date(), taskGroup: Data.Tasks.TaskGroup[0]),
        TaskModel(id: UUID(uuidString: "E721E1F8-C36C-495A-93FC-0C247A3E6E5F")!, title: "Market Research", description: "Grocery shopping app design", status: .inProcess, time: Date(), taskGroup: Data.Tasks.TaskGroup[1]),
        TaskModel(id: UUID(uuidString: "E821E1F8-C36C-495A-93FC-0C247A3E6E5F")!, title: "Market Research", description: "Grocery shopping app design", status: .toDo, time: Date(), taskGroup: Data.Tasks.TaskGroup[2]),
        TaskModel(id: UUID(uuidString: "E921E1F8-C36C-495A-93FC-0C247A3E6E5F")!, title: "Market Research", description: "Grocery shopping app design", status: .done, time: Date(), taskGroup: Data.Tasks.TaskGroup[3]),
        TaskModel(id: UUID(uuidString: "E121E1F8-C36C-495A-93FC-0C247A3E6E5F")!, title: "Market Research", description: "Grocery shopping app design", status: .inProcess, time: Date(), taskGroup: Data.Tasks.TaskGroup[4])
    ]
    
    public func appendTask(model: TaskModel) {
        Task.append(model)
    }
    
   
    
    
}


