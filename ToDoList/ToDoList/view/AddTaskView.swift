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
    
    
    @State private var projectName: String = ""
    @State private var description: String = ""
    
    @State private var startDate = Date()
    @State private var endDate = Date()
    
    @State private var showDatePicker: Bool = false
    
//MARK: Body
    var body: some View {
        VStack {
            navigationBar
            
            taskGroup
            
            ZStack{
                projectNameView

                if showDropDown{
                    withAnimation{
                        dropDown
                    }
                }
                
            }
            descriptionView
            
            SelectDateModel(startDate: $startDate, endDate: $endDate, currentDate: 0, title: "Start Date", showDatePicker: showDatePicker)
            
            SelectDateModel(startDate: $startDate, endDate: $endDate, currentDate: 1, title: "End Date", showDatePicker: showDatePicker)
            
            addProjectBtn
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(BackgroundMode().viewBack())
    }
}

extension AddTaskView {
//MARK: TOP Navigation BAR
    private var navigationBar: some View {
        NavigationTopBar(title: "Add Project")
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
        .environment(\.colorScheme, BackgroundMode().isDark ? .dark : .light)
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
    
//MARK: Product Name
    private var projectNameView: some View {
        VStack(alignment: .leading){
                textView(text: "Product Name", size: 12)
                    .foregroundColor(Color(.systemGray))
                    .padding(.leading)
                    .padding(.top, 10)
                TextField("...", text: $projectName, axis: .vertical)
                    .autocorrectionDisabled()
                    .lineLimit(1, reservesSpace: true)
                    .padding(.leading)
                    .padding(.bottom,10)
        }
        .background(Color.white)
        .cornerRadius(20)
        .padding([.leading, .trailing,.bottom])
        
    }
    
//MARK: Description
    private var descriptionView: some View {
        VStack(alignment: .leading){
            textView(text: "description", size: 12)
                .foregroundColor(Color(.systemGray))
                .padding(.leading)
                .padding(.top, 10)
            TextField("...", text: $description, axis: .vertical)
                .autocorrectionDisabled()
                .lineLimit(6, reservesSpace: true)
                .padding(.leading)
                .padding(.bottom,10)
            
        }
        .frame(maxWidth: .infinity, maxHeight: Size.size[1]/4)
        .background(Color.white)
        .cornerRadius(20)
        .padding([.leading, .trailing,.bottom])
    }
    
//MARK: Add Project
    private var addProjectBtn: some View {
        Button {
            if verifyTask() {

                let cc = Calendar.current
                var currentDate = startDate
                let toDate: Date = cc.date(byAdding: .day, value: 1, to: endDate) ?? .now
                
                repeat {
                    
                    if let nextDate = cc.date(byAdding: .day, value: 1, to: currentDate) {
                            currentDate = nextDate
                    }
                    
                    Data.Tasks.appendTask(model: TaskModel(title: projectName, description: description, status: .toDo, time: currentDate, taskGroup: selectedTaskGroup))
                                        
                } while currentDate <= toDate
            }
            
        } label: {
            textView(text: "Add Project", size: 18)
        }
        .frame(maxWidth: .infinity, maxHeight: Size.size[1]/13)
        .background(Color("purple"))
        .foregroundColor(.white)
        .cornerRadius(20)
        .padding()
    }
    
//MARK: Verification
    private func verifyTask() -> Bool{
        if projectName.isEmpty || description.isEmpty {
            return false
        }
        
        return true
    }
}

#Preview {
    AddTaskView()
}
