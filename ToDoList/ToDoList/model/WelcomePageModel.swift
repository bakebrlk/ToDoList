//
//  WelcomePageClass.swift
//  ToDoList
//
//  Created by bakebrlk on 17.02.2024.
//

import SwiftUI

struct WelcomePageModel: Encodable, Decodable{
    let id: Int
    let title: String
    let description: String
    let imageName: String
}
