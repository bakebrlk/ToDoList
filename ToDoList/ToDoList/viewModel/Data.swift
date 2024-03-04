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
    
    struct Tasks{
        static let inProgress: [inProgressModel] = [
            inProgressModel(group: "Buissness", title: "Buy Flowers", logo: "TaskLogo1", color: .cyan, progress: 0.5),
            inProgressModel(group: "Buissness", title: "Pay for sub", logo: "TaskLogo2", color: .green, progress: 0.2),
            inProgressModel(group: "Buissness", title: "write code", logo: "TaskLogo3", color: .purple, progress: 0.7),
            inProgressModel(group: "Buissness", title: "do project", logo: "TaskLogo4", color: .mint, progress: 0.1),
            inProgressModel(group: "Buissness", title: "conf project", logo: "TaskLogo5", color: .teal, progress: 1.0),
        ]
    }
}
