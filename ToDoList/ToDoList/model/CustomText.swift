//
//  CustomText.swift
//  ToDoList
//
//  Created by bakebrlk on 19.02.2024.
//

import Foundation
import SwiftUI

func textView(text: String, size: CGFloat)-> Text{
    Text(text)
        .font(.custom("LexendDeca-Regular", size: size))
}
