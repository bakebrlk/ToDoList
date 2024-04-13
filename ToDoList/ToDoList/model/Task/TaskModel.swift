//
//  CalendarTaskModel.swift
//  ToDoList
//
//  Created by bakebrlk on 06.03.2024.
//

import SwiftUI
import Combine

struct TaskModel:Identifiable{

    var id: String = ""
    var title: String
    var description: String
    var status: TaskStatus
    let time: Date
    let taskGroup: TaskGroupModel
    var offSet: CGFloat = 0
    var isSwiped: Bool = false
 
    static func == (lhs: TaskModel, rhs: TaskModel) -> Bool {
        return lhs.id == rhs.id
            && lhs.title == rhs.title
            && lhs.description == rhs.description
            && lhs.status == rhs.status
            && lhs.time == rhs.time
            && lhs.taskGroup == rhs.taskGroup
    }

}

struct TaskViewCell: View{
    
//    @StateObject var db = TaskData()
//    public let user = Data.User()
//    
//    public static func setViewModel(db: TaskData){
//        self.db = db
//        Task{
//            try await user.userInfo()
//        }
//    }
    
    var model: TaskModel
    
    var body: some View {

        ZStack{
            
            Color.white
                .cornerRadius(20)
                .padding(10)
            
            HStack{
                Button {
//                    self.offsetTask(task: model, width: 1000)
//                    self.deleteTask(task: model)
//                    print(model)
//                    Timer.scheduledTimer(withTimeInterval: 0.15, repeats: false) {_ in
//                        withAnimation{
//                            self.deleteTask(task: model)
//                        }
//                    }
                } label: {
                    Image(systemName: "trash")
                        .frame(width: Size.size[0]/5)
                        .foregroundColor(.white.opacity(0.8))
                }
                .frame(maxWidth:Size.size[1]/10, maxHeight: Size.size[1]/6)
                .background(Color.red)
                
                Spacer()
                HStack{
                    
                    Button {
//                        updateStatus(task: model, status: .toDo)
                    } label: {
                        
                        Image(systemName: "square.and.pencil")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(Color.cyan)
                            .padding()
                    }
                    .frame(width: Size.size[0]/7, height: Size.size[1]/15)
                    
                    Button {
//                        self.updateStatus(task: model, status: .inProcess)
                            
                    } label: {
                        Image(systemName: "rectangle.and.pencil.and.ellipsis.rtl")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(Color.yellow)
                            .padding()
                    }
                    .frame(width: Size.size[0]/7, height: Size.size[1]/15)
                    
                    Button {
//                        self.updateStatus(task: model, status: .done)
                    } label: {
                        Image(systemName: "checkmark.circle")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(Color.green)
                            .padding()
                    }
                    .frame(width: Size.size[0]/7, height: Size.size[1]/15)
                    
                }
                .frame(width: Size.size[1]/4, height: Size.size[1]/6)
                .background(BackgroundMode().avtorColor())
            }
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
            .offset(x: model.offSet)
        }
        .frame(maxWidth: .infinity, maxHeight: Size.size[1]/6)
        .cornerRadius(20)
        .padding(10)

    }

    
//    public func updateStatus(task: TaskModel, status: TaskStatus) {
//    
//        Task{
//            if let user = user.user{
//                DispatchQueue.main.async {
//                    FirebaseFunction.updateTask(userId: user.id, taskID: task.id, title: nil, description: nil, status: status)
//                }
//            }
//            
//            offsetTask(task: task, width: 0)
//        }
//        
//        Task{
//            DispatchQueue.main.async{
//                self.db.updateStatus(task: task, status: status)
//            }
//        }
//    }
//    
//    public func deleteTask(task: TaskModel){
//        for i in 0..<db.Task.count {
//            if db.Task[i].id == task.id{
//                db.Task.remove(at: i)
//                break
//            }
//        }
//    }
//    
//    public func offsetTask(task: TaskModel, width: CGFloat){
//        withAnimation{
//            db.offSet(task: task, 0)
//        }
//    }
}
