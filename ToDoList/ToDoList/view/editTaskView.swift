//
//  editTaskView.swift
//  Taskly
//
//  Created by bakebrlk on 08.04.2024.
//

import SwiftUI

struct editTaskView: View {
    
    @State private var title: String = ""
    @State private var description: String = ""
    
    private var task: TaskModel
    @Binding private var showEditTask: Bool
    private var db: TaskData
    
    @ObservedObject private var viewModel: ViewModel = ViewModel()
    
    init(task: TaskModel,showEditTask: Binding<Bool>, db: TaskData) {
        self.task = task
        _showEditTask = showEditTask
        self.db = db
    }
    
    var body: some View {
        VStack{
            Rectangle()
                .frame(width: 50, height: 4)
                .background(BackgroundMode().textColor())
                .cornerRadius(16)
                .padding()
            
            textView(text: "Edit Task", size: 22)
                .padding(10)
            textField(text: "Title: ", helpText: viewModel.getTask().title, mainText: $title, textLimit: 1)
            textField(text: "Description: ", helpText: viewModel.getTask().description, mainText: $description, textLimit: 3)
            
            Spacer()
            
            Button(action: {
                
                viewModel.setDB(db: db)
                
                let title: String? = (!title.isEmpty) ? title : nil
                let description = (!description.isEmpty) ? description : nil
                viewModel.updateData(task: task, title: title, description: description)
                
                showEditTask.toggle()
            }, label: {
                textView(text: "Edit", size: 22)
                    .frame(maxWidth: .infinity, maxHeight: Size.size[1]/14)
                    .foregroundColor(.white)
            })
            .background(BackgroundMode().avtorColor())
            .cornerRadius(20)
            .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(BackgroundMode().viewBack())
        .onAppear{
            viewModel.setTask(task: task)
        }
    }
}

extension editTaskView{
    private func textField(text: String,helpText: String, mainText: Binding<String>, textLimit: Int) -> some View {
        VStack(alignment: .leading){
                textView(text: text, size: 12)
                    .foregroundColor(Color(.systemGray))
                    .padding(.leading)
                    .padding(.top, 10)
            
            TextField(helpText, text: mainText, axis: .vertical)
                    .autocorrectionDisabled()
                    .lineLimit(textLimit, reservesSpace: true)
                    .padding(.leading)
                    .padding(.bottom,10)
                    .onTapGesture {
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    }
            
        }
        .background(Color.white)
        .cornerRadius(20)
        .padding([.leading, .trailing,.bottom])
        
    }
}


