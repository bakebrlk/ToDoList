//
//  CustomButton.swift
//  ToDoList
//
//  Created by bakebrlk on 19.02.2024.
//

import Foundation
import SwiftUI

func customButton(text: String, action: ()) -> Button<some View>{
    Button(
        action: {
            action
        },
        label: {
            textView(text: text, size: 22)
                
    })
}
