//
//  editTaskViewModel.swift
//  Taskly
//
//  Created by bakebrlk on 08.04.2024.
//

import Foundation
import SwiftUI

extension CalendarPageView{
    class ViewModel: ObservableObject {
        @Published private var selectedTask: TaskModel = TaskModel(title: "", description: "", status: .all, time: Date(), taskGroup: Data.Tasks.TaskGroup[0])
        
        public func setTask(task: TaskModel) {
            selectedTask = task
        }
        
        public func getTask() -> TaskModel {
            return selectedTask
        }
    }
}
