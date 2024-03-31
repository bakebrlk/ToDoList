//
//  TopTitleView.swift
//  ToDoList
//
//  Created by bakebrlk on 06.03.2024.
//

import SwiftUI

public func NavigationTopBar(title: String) -> some View{
    HStack{

        Spacer()
        textView(text: title, size: 18)
            .foregroundColor(BackgroundMode().textColor())
            .padding(.leading)
        
        Spacer()
        Button(action: {
            
        }, label: {
            CustomImage.getImage(systemName: "ellipsis.message")
                .foregroundColor(BackgroundMode().textColor())
        })
    }
    .frame(maxWidth: Size.size[0], maxHeight: Size.size[1]*0.03)
    .padding()
}
