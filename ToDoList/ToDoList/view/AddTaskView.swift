//
//  AddTaskView.swift
//  ToDoList
//
//  Created by bakebrlk on 11.03.2024.
//

import SwiftUI

struct AddTaskView: View {
    
    @State private var selectedTaskGroup: TaskGroupModel = Data.Tasks.TaskGroup[0]
    @State private var showDropDown: Bool = false
    
    var body: some View {
        VStack {
            navigationBar
            
            taskGroup
            
            if showDropDown{
                withAnimation{
                    dropDown
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.cyan.opacity(0.1))
    }
}

extension AddTaskView {
//MARK: TOP Navigation BAR
    private var navigationBar: some View {
        NavigationTopBar(title: "Add Project", backAction: backAction())
    }
    
    private func backAction(){
        
    }

//MARK: Task Group
    private var taskGroup: some View {
        HStack{
           
            Image(selectedTaskGroup.img)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding([.top, .bottom, .leading])
            
            VStack(alignment: .leading){
                textView(text: "Task Group", size: 14)
                    .foregroundColor(Color(.systemGray))
                textView(text: selectedTaskGroup.title, size: 18)
            }
            Spacer()
            
            Image(systemName: showDropDown ? "arrowtriangle.up.fill" : "arrowtriangle.down.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(24)
        }
        .frame(maxWidth: .infinity, maxHeight: Size.size[1]/12)
        .background(Color.white)
        .cornerRadius(20)
        .padding()
        
        .onTapGesture {
            withAnimation{
                showDropDown.toggle()
            }
        }
    }
    
//MARK: Drop Down
    private var dropDown: some View {
        ScrollView(.vertical){
            ForEach(Data.Tasks.TaskGroup){ group in
                VStack{
                    taskGroupModel(taskGroup: group)
                    
                    Rectangle()
                        .frame(maxWidth: .infinity, maxHeight: 2)
                        .foregroundColor(Color(.systemGray5))
                        .padding([.leading,.trailing])
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: Size.size[1]/4)
        .background(Color.white)
        .cornerRadius(20)
        .padding([.leading, .trailing])
    }
    
    private func taskGroupModel(taskGroup: TaskGroupModel) -> some View {
        HStack{
            Image(taskGroup.img)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding([.top, .bottom, .leading], 10)
    
                textView(text: taskGroup.title, size: 20)
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: Size.size[1]/15)
        .padding([.leading,.trailing, .top], 10)
        
        .onTapGesture {
            withAnimation{
                selectedTaskGroup = taskGroup
                showDropDown.toggle()
            }
        }
    }
}

#Preview {
    AddTaskView()
}
