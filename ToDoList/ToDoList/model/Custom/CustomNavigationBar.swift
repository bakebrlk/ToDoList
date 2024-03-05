//
//  TopTitleView.swift
//  ToDoList
//
//  Created by bakebrlk on 06.03.2024.
//

import SwiftUI

public func topTitleView(title: String, action: ()) -> some View{
    HStack{
        Button(action: {
            
        }, label: {
            /*@START_MENU_TOKEN@*/Text("Button")/*@END_MENU_TOKEN@*/
        })
        textView(text: title, size: 18)
    }
}
