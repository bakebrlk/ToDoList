//
//  CalendarView.swift
//  ToDoList
//
//  Created by bakebrlk on 06.03.2024.
//

import SwiftUI

struct CalendarPageView: View {
    
    private let taskVariant = ["All","To do", "In Progress", "Done"]

    @State private var taskVariantId = 0
    
    var body: some View {
        VStack{
            navigationBar
            
            calendar()
            
            filterTask()
        }
        .frame(maxWidth: .infinity,maxHeight: .infinity)
        .background(Color.cyan.opacity(0.1))
    }
}

extension CalendarPageView {
    
//MARK: TOP Navigation BAR
    private var navigationBar: some View {
        NavigationTopBar(title: "Today's Task", backAction: backAction())
    }
    
    private func backAction(){
        
    }
    
//MARK: Calendar
    private func calendar() -> some View {
        HStack{
            CalendarModel.shared.forCalendarPage(date: Date())
        }
        .padding()
    }
    
//MARK: Filter Task
    private func filterTask() -> some View {
        ScrollView(.horizontal,showsIndicators: false){
            HStack{
                ForEach(0..<taskVariant.count, id: \.self){ id in
                   filterTaskView(id: id)
                }
            }
            .padding(.leading)
        }
        .frame(maxWidth: .infinity)
    }
    
    private func filterTaskView(id: Int) -> some View {
        Button(action: {
            taskVariantId = id
        }, label: {
            textView(text: taskVariant[id], size: 16)
                .padding([.leading,.trailing],20)
                .padding([.top,.bottom],10)
                .foregroundColor(taskVariantId == id ? .white : Color("purple"))
        })
        .background(Color("purple").opacity(taskVariantId == id ? 1 : 0.1))
        .cornerRadius(16)
        .padding(5)
    }
}

#Preview {
    CalendarPageView()
}
