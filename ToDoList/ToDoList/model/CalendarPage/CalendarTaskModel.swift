//
//  CalendarTaskModel.swift
//  ToDoList
//
//  Created by bakebrlk on 06.03.2024.
//

import SwiftUI

struct CalendarTaskModel:Identifiable, Hashable{
    var id = UUID()
    let title: String
    let description: String
    let status: String
    let time: Date
    let image: String
}
