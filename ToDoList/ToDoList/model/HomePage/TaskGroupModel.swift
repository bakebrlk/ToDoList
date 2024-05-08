//
//  File.swift
//  ToDoList
//
//  Created by bakebrlk on 06.03.2024.
//

import SwiftUI

struct TaskGroupModel:Identifiable, Hashable{
    var id = UUID()
    let title: String
    var count: CGFloat
    let img: String
    var process: CGFloat
    let color: Color
    var doneCount: CGFloat
}
