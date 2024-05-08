//
//  AddTaskView.swift
//  ToDoList
//
//  Created by bakebrlk on 11.03.2024.
//

import SwiftUI

struct AddTaskView: View {
    
    @StateObject public var user = UserResponse()
    @ObservedObject var viewModel = ViewModel()
    @EnvironmentObject var navigate: Navigation

    @State private var selectedTaskGroup: TaskGroupModel = Data.Tasks().TaskGroup[0]
    @State private var showDropDown: Bool = false
    
    @State private var projectName: String = ""
    @State private var description: String = ""
    
    @State private var verifyTitle = false
    @State private var verifyDescription = false
    
    @State private var startDate = Date()
    @State private var endDate = Date()
    
    @State private var showDatePicker: Bool = false
    
    @State private var isLoading = false
    @State private var isSuccess = false
    
    @StateObject var db: TaskData

//MARK: Body
    var body: some View {
        ZStack{
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
            
            if isLoading {
                Color(.systemBackground)
                    .ignoresSafeArea()
                    .opacity(0.4)
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: Color("purple")))
                    .scaleEffect(3)
            }
            
            if isSuccess {
                Color(.systemBackground)
                    .ignoresSafeArea()
                    .opacity(0.4)
                
                VStack{
                    Image(systemName: "checkmark.circle")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100, height: 100)
                        .foregroundColor(.green)
                    
                    textView(text: "Success", size: 22)
                        .foregroundColor(.green)
                        .padding(.top)
                }
            }
        }
    }
}

extension AddTaskView {
    
//MARK: Loading
    private func loading(){
        withAnimation{
            isLoading = true
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            
            withAnimation{
                projectName = ""
                description = ""
                startDate = Date()
                endDate = Date()
                selectedTaskGroup = Data.Tasks().TaskGroup[0]
                
                isLoading = false
                isSuccess = true
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                withAnimation{
                    isSuccess = false
                }
            }
        }
    }
    
//MARK: TOP Navigation BAR
    private var navigationBar: some View {
        NavigationBar().NavigationTopBar(title: "Add Project", navigateTo: navigateChat)
    }
    
    private func navigateChat(){
        navigate.navigateTo(.chat)
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
            ForEach(Data.Tasks().TaskGroup){ group in
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
                    .onTapGesture {
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    }
        }
        .background(Color.white)
        .cornerRadius(20)
        .overlay(
              RoundedRectangle(cornerRadius: 20)
                .stroke(verifyTitle ? .red : .white, lineWidth: 2)
          )
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
                .onTapGesture {
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                }
            
        }
        .frame(maxWidth: .infinity, maxHeight: Size.size[1]/4)
        .background(Color.white)
        .cornerRadius(20)
        .overlay(
              RoundedRectangle(cornerRadius: 20)
                .stroke(verifyDescription ? .red : .white, lineWidth: 2)
          )
        .padding([.leading, .trailing,.bottom])
    }
    
//MARK: Add Project
    private var addProjectBtn: some View {
        Button {

            if verifyTask() {

                loading()
                
                let cc = Calendar.current
                var currentDate = startDate
                
                while currentDate <= endDate{

                    let newTask = TaskModel(id: UUID().uuidString, title: projectName, description: description, status: .toDo, time: currentDate, taskGroup: selectedTaskGroup)
                    
                    db.Task.append(newTask)
                    
                    viewModel.addTask(userId: user.user!.id, taskModel: newTask)
                    
                    print(currentDate)
                    if let nextDate = cc.date(byAdding: .day, value: 1, to: currentDate) {
                            currentDate = nextDate
                    }
                }
            }else{
                if projectName.isEmpty{
                    verifyTitle = true
                }
                
                if description.isEmpty{
                    verifyDescription = true
                }
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
        
        verifyTitle = false
        verifyDescription = false
        
        return true
    }
}
