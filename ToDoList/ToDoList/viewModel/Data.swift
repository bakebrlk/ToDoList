//
//  WelcomePageData.swift
//  ToDoList
//
//  Created by bakebrlk on 17.02.2024.
//

import SwiftUI

struct Data{
     
    struct WelcomePage{
        static let data: [WelcomePageModel] = [
            WelcomePageModel(id: 0,
                             title: "Task Management & To-Do List",
                             description: "This productive tool is designed to help you better manage your task project-wise conveniently!",
                             imageName: "onbording1"),
            WelcomePageModel(id: 1,
                             title: "Project Management",
                             description: "Group related tasks into projects for better organization and tracking of progress.",
                             imageName: "onbording2"),
            WelcomePageModel(id: 1,
                             title: "Deadline Tracking",
                             description: "Set due dates and receive reminders to ensure you never miss an important deadline again.",
                             imageName: "onbording3"),
            
        ]
    }
    
    final class Tasks: ObservableObject{
        
        @Published var TaskGroup: [TaskGroupModel] = [
            TaskGroupModel(title: "Education and Learning", count: 0, img: "taskLogo1", process: 0.0, color: .red.opacity(0.6), doneCount: 0),
            TaskGroupModel(title: "Health and Fitness", count: 0, img: "taskLogo3", process: 0.0, color: .purple.opacity(0.6), doneCount: 0),
            TaskGroupModel(title: "Personal tasks", count: 0, img: "taskLogo2", process: 0.0, color: .blue.opacity(0.6), doneCount: 0),
            TaskGroupModel(title: "Work tasks", count: 0, img: "taskLogo4", process: 0.0, color: .yellow.opacity(0.6), doneCount: 0),
            TaskGroupModel(title: "Others", count: 0, img: "taskLogo5", process: 0.0, color: .mint.opacity(0.6), doneCount: 0)
       ]

        public func appendCount(taskGroup: TaskGroupModel, isDone: Bool){
            
            for i in TaskGroup.indices {
                if taskGroup.title == TaskGroup[i].title {
                    if isDone {
                        TaskGroup[i].doneCount += 1
                    }
                    TaskGroup[i].count += 1
                    break
                }
            }
        }
        
        public func statistics(group: TaskGroupModel){
            
            for i in TaskGroup.indices {
                if group.title == TaskGroup[i].title {
                    if TaskGroup[i].count > 0 {
                        withAnimation{
                            TaskGroup[i].process = TaskGroup[i].doneCount/TaskGroup[i].count
                        }
                    }
                    break
                    
                }
            }
        }
        
    }
}

