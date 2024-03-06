//
//  TaskStatus.swift
//  ToDoList
//
//  Created by bakebrlk on 06.03.2024.
//

import SwiftUI

enum TaskStatus{
    case done
    case toDo
    case inProcess
    case all
    
    var builder: String{
        switch self {
        case .done:
            "Done"
        case .toDo:
            "To do"
        case .inProcess:
            "In Process"
        case .all:
            "All"
        }
    }
}
