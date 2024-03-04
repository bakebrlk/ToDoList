//
//  inProgressModel.swift
//  ToDoList
//
//  Created by bakebrlk on 04.03.2024.
//

import SwiftUI

struct inProgressModel:Identifiable, Hashable{
    var id = UUID()
    let group: String
    let title: String
    let logo: String
    let color: Color
    let progress: CGFloat
}
