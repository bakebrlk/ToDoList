//
//  TopTitleView.swift
//  ToDoList
//
//  Created by bakebrlk on 06.03.2024.
//

import SwiftUI

public func NavigationTopBar(title: String, backAction: ()) -> some View{
    HStack{
        
        customButton(text: "<-", action: backAction)
            .frame(maxWidth: Size.size[0]*0.06)
            .foregroundColor(.black)
        
        Spacer()
        textView(text: title, size: 18)
        Spacer()
        Button(action: {
            
        }, label: {
            CustomImage.getImage(systemName: "bell.fill")
                .foregroundColor(.black)
        })
    }
    .frame(maxWidth: Size.size[0], maxHeight: Size.size[1]*0.03)
    .padding()
}
