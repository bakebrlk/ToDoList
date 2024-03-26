//
//  CalendarTaskModel.swift
//  ToDoList
//
//  Created by bakebrlk on 06.03.2024.
//

import SwiftUI

struct TaskModel:Identifiable, Hashable{
    var id = UUID()
    let title: String
    let description: String
    let status: TaskStatus
    let time: Date
    let taskGroup: TaskGroupModel
    
    public static func TaskModel(model: TaskModel) -> some View {
        HStack{
            
            VStack(alignment: .leading){
                textView(text: model.description, size: 12)
                    .foregroundColor(Color(.systemGray))
                
                textView(text: model.title, size: 14)
                    .foregroundColor(.black)
                    .padding([.top,.bottom],5)
                HStack{
                    CustomImage.getImage(systemName: "clock.fill")
                        .foregroundColor(Color("purple").opacity(0.5))
                    
                    textView(text: CalendarModel.shared.time(currentDate: model.time), size: 12)
                        .foregroundColor(Color("purple").opacity(0.5))
                    Spacer()
                }
                .frame(maxWidth: Size.size[0]*0.5, maxHeight: Size.size[1]*0.02)
            }
            .padding()
            
            Spacer()
            VStack(alignment: .trailing){
                CustomImage.getImage(imageName: model.taskGroup.img)
                    .frame(maxHeight: 30)
                
                Spacer()
                textView(text: model.status.builder, size: 12)
                    .padding([.leading,.trailing],20)
                    .padding([.top,.bottom],10)
                    .background(model.taskGroup.color)
                    .cornerRadius(16)
            }
            .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: Size.size[1]/6)
        .background(Color.white.opacity(BackgroundMode().isDark ? 0.92 : 1))
        .cornerRadius(20)
        .padding(10)
    }
}
