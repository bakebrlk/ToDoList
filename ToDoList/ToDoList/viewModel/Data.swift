//
//  WelcomePageData.swift
//  ToDoList
//
//  Created by bakebrlk on 17.02.2024.
//

import SwiftUI

final class Data: ObservableObject{
    
    final class User: ObservableObject{
        
        @Published var user: UserModel? = nil
        
        public func userInfo() async throws{
            let authDataResult = try FirebaseFunction.getAuthenticatedUser()
            let userInfo = try await FirebaseFunction.getUserInfo(userId: authDataResult.uid)
                    
            DispatchQueue.main.async {
                self.user = userInfo
            }
        }
        
        public func editUser(nick: String) async throws{
            try await FirebaseFunction.updateUser(userId: user!.id, nickName: nick)
            let updateUser = try await FirebaseFunction.getUserInfo(userId: user!.id)
            
            DispatchQueue.main.async {
                self.user = updateUser
            }
        }
    }
    
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
        
    struct Tasks{
                            
        static func appendTask(model: TaskModel) {
            Task.append(model)
        }
                
        static var inProgress: [inProgressModel] = [
            inProgressModel(group: "Buissness", title: "Buy Flowers", logo: "taskLogo1", color: .cyan, progress: 0.5),
            inProgressModel(group: "Buissness", title: "Pay for sub", logo: "taskLogo2", color: .green, progress: 0.2),
            inProgressModel(group: "Buissness", title: "write code", logo: "taskLogo3", color: .purple, progress: 0.7),
            inProgressModel(group: "Buissness", title: "do project", logo: "taskLogo4", color: .mint, progress: 0.1),
            inProgressModel(group: "Buissness", title: "conf project", logo: "taskLogo5", color: .teal, progress: 1.0),
        ]
        
        static var TaskGroup: [TaskGroupModel] = [
            TaskGroupModel(title: "Buissness", count: 20, img: "taskLogo1", process: 0.5, color: .red.opacity(0.6)),
            TaskGroupModel(title: "Buissness", count: 5, img: "taskLogo3", process: 0.2, color: .purple.opacity(0.6)),
            TaskGroupModel(title: "Buissness", count: 1, img: "taskLogo2", process: 0.1, color: .blue.opacity(0.6)),
            TaskGroupModel(title: "Buissness", count: 30, img: "taskLogo4", process: 0.4, color: .yellow.opacity(0.6)),
            TaskGroupModel(title: "Buissness", count: 15, img: "taskLogo5", process: 0.9, color: .mint.opacity(0.6))
        ]

        static var Task: [TaskModel] = [
            TaskModel(title: "Market Research", description: "Grocery shopping app design", status: .done, time: Date(),taskGroup: Data.Tasks.TaskGroup[0]),
            TaskModel(title: "Market Research", description: "Grocery shopping app design", status: .inProcess, time: Date(), taskGroup: Data.Tasks.TaskGroup[1]),
            TaskModel(title: "Market Research", description: "Grocery shopping app design", status: .toDo, time: Date(), taskGroup: Data.Tasks.TaskGroup[2]),
            TaskModel(title: "Market Research", description: "Grocery shopping app design", status: .done, time: Date(), taskGroup: Data.Tasks.TaskGroup[3]),
            TaskModel(title: "Market Research", description: "Grocery shopping app design", status: .inProcess, time: Date(), taskGroup: Data.Tasks.TaskGroup[4]),
        ]
    }
}

