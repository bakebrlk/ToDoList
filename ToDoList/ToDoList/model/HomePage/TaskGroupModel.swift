//
//  File.swift
//  ToDoList
//
//  Created by bakebrlk on 06.03.2024.
//

import SwiftUI

struct TaskGroupModel:Identifiable, Hashable{
    var id: ObjectIdentifier
    let title: String
    let count: Int
    let ava: String
    let process: CGFloat
}
