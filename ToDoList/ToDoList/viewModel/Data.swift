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
}
