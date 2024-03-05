//
//  cartModel.swift
//  ToDoList
//
//  Created by bakebrlk on 04.03.2024.
//

import SwiftUI

struct cartModel{
        
    static func getInProgress(model: inProgressModel) -> some View{
        VStack {
            HStack{
                textView(text: model.group, size: 14)
                    .foregroundStyle(Color(UIColor.systemGray6))
                Image(model.logo)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
            .frame(maxHeight: Size.size[1]*0.04)
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
    
    static func getTaskGroup(model: TaskGroupModel) -> some View {
        HStack{
            Image(model.ava)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding()
            
            VStack(alignment: .leading){
                textView(text: model.title, size: 14)
                textView(text: "\(model.count) Tasks", size: 10)
                    .foregroundColor(Color(.systemGray))
                    .padding(.top,0.1)
            }
            Spacer()
            
            CircleModel(process: .constant(model.process), textSize: 14, textColor: .black, colors: [model.color]).statisticsCircles(width: 50, height: 50)
                .padding(.trailing)
        }
        .frame(width: Size.size[0]*0.9, height: Size.size[1]*0.1)
        .background(.white.opacity(0.6))
        .cornerRadius(20)
        .padding(.leading)
    }
}
