//
//  AddTaskViewModel.swift
//  Taskly
//
//  Created by bakebrlk on 05.04.2024.
//

import SwiftUI
import Foundation

extension AddTaskView{
    
    class ViewModel: ObservableObject  {
        
        public func addTask(userId: String ,taskModel: TaskModel){
            Task{
                try await FirebaseFunction.createTask(userID: userId ,model: taskModel)
            }
        }
    }
}
