//
//  CustomTabBar.swift
//  ToDoList
//
//  Created by bakebrlk on 20.03.2024.
//

import SwiftUI

struct CustomTabBar: View {
    
    @State private var id = 0
    
    @ObservedObject public var backgroundMode: BackgroundMode
    
    @StateObject public var user: UserResponse
    @StateObject var db: TaskData

    @Binding public var avatarData: Foundation.Data?
    @StateObject public var taskGroup: Data.Tasks
    
//MARK: Body
    var body: some View {
        VStack{
            if id == 0 {
                HomePageView(avatarData: $avatarData, user: user, db: db, pageId: $id, taskGroup: taskGroup)
                
            }else if id == 1{
                CalendarPageView( db: db)
                
            }else if id == 2 {
                AddTaskView(user: user, db: db)
                
            }else if id == 3 {
                TimerView()
                
            }else if id == 4 {
                ProfileView(user: user, backMode: backgroundMode, avatarData: $avatarData)
            }
            
            Spacer()
            tabBar
                
        }
    
        .background(BackgroundMode().viewBack())
        .onAppear{
            id = 0
            db.Task.sort { $0.time < $1.time }
        }
    }
    
}

extension CustomTabBar {
    
    private var tabBar: some View {
        ZStack(){
            
            Color("purple").opacity(BackgroundMode().isDark ? 0.5 :  0.2)
                .frame(width: Size.size[0], height: Size.size[1]/10)
                .clipShape(
                    .rect(
                        topLeadingRadius: 35,
                        bottomLeadingRadius: 0,
                        bottomTrailingRadius: 0,
                        topTrailingRadius: 35
                        
                    )
                )
                .offset(y: 17)
            
            HStack(alignment: .bottom){
                
                getButton(id: 0, image: Image(systemName: "house.fill"))
                    .frame(width: 30, height: 30)
                    .padding([.bottom], 10)
                    .padding([.leading, .trailing,], 15)
                
                getButton(id: 1, image: Image(systemName: "calendar"))
                    .frame(width: 30, height: 30)
                    .padding([.bottom], 10)
                    .padding([.leading, .trailing,], 15)
                
                getButton(id: 2, image: Image(systemName: "plus.circle.fill"))
                    .padding(10)
                    .frame(maxWidth: Size.size[0]/6, maxHeight: Size.size[0]/6)
                    .background(BackgroundMode().viewBack())
                    .cornerRadius(Size.size[0]/10)
                    .offset(y: -Size.size[1]/50)
                
                getButton(id: 3, image: Image(systemName: "gauge.with.needle"))
                    .frame(width: 30, height: 30)
                    .padding([.bottom], 10)
                    .padding([.leading, .trailing,], 15)
                
                getButton(id: 4, image: Image(systemName: "person.crop.circle"))
                    .frame(width: 30, height: 30)
                    .padding([.bottom], 10)
                    .padding([.leading, .trailing,], 15)
            }
            .background(Color.clear)

        }
        .frame(maxWidth: .infinity, maxHeight: Size.size[1]/26)
        .background(Color.clear)

    }
    
    private func getButton(id: Int, image: Image) -> some View {
        Button(action:{
            self.id = id
        }, label: {
            image
                .resizable()
                .aspectRatio(contentMode: .fill)
                .foregroundColor(BackgroundMode().isDark ? .yellow : Color("purple"))
        })

    }
}

