//
//  CustomButton.swift
//  ToDoList
//
//  Created by bakebrlk on 19.02.2024.
//

import Foundation
import SwiftUI

func customButton(text: String, action: ()) -> some View{
    Button(
        action: {
            action
        },
        label: {
            textView(text: text, size: 22)
                
    })
    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
    .cornerRadius(18)
}
