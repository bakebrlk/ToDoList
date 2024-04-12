//
//  editTaskViewModel.swift
//  Taskly
//
//  Created by bakebrlk on 08.04.2024.
//

import Foundation
import SwiftUI

extension editTaskView{
    class ViewModel: ObservableObject {
        @Published private var selectedTask: TaskModel = TaskModel(title: "", description: "", status: .all, time: Date(), taskGroup: Data.Tasks.TaskGroup[0])
        
        public let user = Data.User()

        public var db = TaskData()
        
        public func setTask(task: TaskModel) {
            selectedTask = task
        }
        
        public func setDB(db: TaskData){
            self.db = db
        }
        
        public func getTask() -> TaskModel {
            return selectedTask
        }
        
        public func updateData(task: TaskModel, title: String?, description: String?){

            for i in 0..<db.Task.count {
                if db.Task[i].id == task.id{
                    if let title = title, let description = description{
                        db.Task[i].title = title
                        db.Task[i].description = description
                    }else if let title = title {
                        db.Task[i].title = title
                        print(title)

                    }else if let description = description{
                        db.Task[i].description = description
                    }
                }
            }
            
        }
        
     
    }
    
    
}
