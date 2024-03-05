//
//  cartModel.swift
//  ToDoList
//
//  Created by bakebrlk on 04.03.2024.
//

import SwiftUI

struct cartModel{
        
    static func getInPro(model: inProgressModel) -> some View{
        VStack {
            HStack{
                textView(text: model.group, size: 14)
                    .foregroundStyle(Color(UIColor.systemGray6))
                Image(model.logo)
                    .frame(width: 25, height: 25)
                    .cornerRadius(8)
            }
            .padding()
            
            textView(text: model.title, size: 18)
                .foregroundStyle(.black)
            
            RecrangleModel(process: .constant(model.progress), color: model.color).statisticRectangle()
                .padding()
        }
        .frame(width: Size.size[0]*0.55)
        .background(model.color.opacity(0.5))
        .cornerRadius(20)
        .padding(.leading)
    }
}
