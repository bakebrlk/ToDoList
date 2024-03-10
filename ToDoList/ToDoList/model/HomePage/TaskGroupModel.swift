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
    let count: Int
    let img: String
    let process: CGFloat
    let color: Color
}
