//
//  HomePageView.swift
//  ToDoList
//
//  Created by bakebrlk on 01.03.2024.
//

import SwiftUI

struct HomePageView: View {
    
    @Binding public var avatarData: Foundation.Data?

    @State private var todayStatus: String = "Your today's task almost done!"
    @State private var statisticsValue = 0.0
  
    @EnvironmentObject var navigate: Navigation
    @StateObject public var user: UserResponse
    @StateObject var db: TaskData
    @Binding var pageId: Int
    @StateObject public var taskGroup: Data.Tasks
    
    @State private var inProgressTasks: [inProgressModel] = []
    
    @State private var onAppear: Bool = false
    
    //MARK: Body
    var body: some View {
        
            GeometryReader { make in
                VStack(alignment: .leading){
                    topBar(height: make.size.height)
                    
                    allStatistics(height: make.size.height, width: make.size.width)
                    
                    inProgress()
                    
                    TaskGroup()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(BackgroundMode().viewBack())
                .environment(\.colorScheme, BackgroundMode().isDark ? .dark : .light)
            }
            .onAppear{
                
                for ind in taskGroup.TaskGroup.indices {
                    taskGroup.TaskGroup[ind].count = 0
                    taskGroup.TaskGroup[ind].doneCount = 0
                }
                
                for task in db.Task {
                    taskGroup.appendCount(taskGroup: task.taskGroup, isDone: task.status == .done)
                }
                
                for group in taskGroup.TaskGroup {
                    taskGroup.statistics(group: group)
                }
                
                inProgressTasks = db.getInProgressTasks()

                withAnimation{
                    statisticsValue = db.todayStatistic()
                }
            }
               
            
           
    }
}

extension HomePageView{
    
    // MARK: - TOP BAR
    private func topBar(height: CGFloat) -> some View{
        HStack{
            avatar(height: height/10)
            userName
            Spacer()
            
            chat
                .frame(maxHeight: height/13)
                .foregroundColor(BackgroundMode().textColor())
        }
        .frame(maxWidth: .infinity, maxHeight: height/10)
    }
    
    private var userName: some View{
        VStack(alignment: .leading){
            textView(text: "Hello!", size: 18)
                .foregroundColor(BackgroundMode().textColor())
            textView(text: user.user?.name ?? "User", size: 22)
                .foregroundColor(BackgroundMode().textColor())
        }
    }
    
    private func avatar(height: CGFloat) -> some View {
        Group{
            CustomImage.getImage(uiImage: (UIImage(data: avatarData ?? Foundation.Data()) ?? UIImage(named: "checkAcc"))!, height: Size.size[1]/4)
            
        }
        .frame(maxWidth: height, maxHeight: height)
        .cornerRadius(height/4)
        .padding(.leading)
    }
    
    private var chat: some View {
        CustomImage.getImage(systemName: "ellipsis.message")
            .padding()
            .onTapGesture {
                navigate.navigateTo(.chat)
            }
    }
    
    //MARK: All Statistics
    
    private func allStatistics(height: CGFloat, width: CGFloat) -> some View{
        HStack {
            VStack(alignment: .leading){
                todayStatusView
                    .lineLimit(nil)

                Spacer()
                viewTaskBtn(width: width/2.5, height: height/16)
                
            }
            .frame(maxWidth: width/2.35)
            .padding()
            
            statisticsCircle(width: width/4.4, height: width/4.4)
         
            VStack{
                optionsBTN
                Spacer()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: height/4)
        .background(Color("purple"))
        .cornerRadius(26)
        .padding()
    }
    
    private var todayStatusView: some View {
        textView(text: todayStatus, size: 16)
            .foregroundColor(.white)
            .padding(.top)
    }
    
    private func viewTaskBtn(width: CGFloat, height: CGFloat) -> some View {
        customButton(text: "View Task", action: openTask)
            .frame(maxWidth: width, maxHeight: height)
            .background(Color.white)
            .foregroundColor(Color("purple"))
            .cornerRadius(16)
            .padding(.bottom)
    }
    
    private func openTask(){
        withAnimation{
            pageId = 1
        }
    }
    
    private func statisticsCircle(width: CGFloat, height: CGFloat) -> some View {
        CircleModel(process: $statisticsValue, textSize: 28, textColor: .white, colors: [Color.purple, Color.blue] ).statisticsCircles(width: width, height: height)
    }
        
    private var optionsBTN: some View {
            
        Button(action: {
            openOptions()
        }
               , label: {
            VStack{
                Text("...")
                    .font(.system(size: 14))
                    .foregroundStyle(Color.white)
                  Spacer()
            }
        })
            .frame(width: 25, height: 25)
            .background(Gradient(colors: [.white.opacity(0.5), .gray.opacity(0.5)]))
            .cornerRadius(8)
            .padding()
    }
    
    private func openOptions(){
        withAnimation{
            statisticsValue = db.todayStatistic()
        }
    }
    
    //MARK: In Progress - Group
    
    private func inProgress() -> some View{
        
        VStack(alignment: .leading){
            
            textView(text: "In Progress (\(inProgressTasks.count))", size: 18)
                .foregroundColor(BackgroundMode().textColor())
                .padding(.leading)
            
            ScrollView(.horizontal, showsIndicators: false){
                HStack{
                    
                    ForEach(inProgressTasks){ task in
                        cartModel.getInProgress(model: task)
                    }
                    
                    if inProgressTasks.count == 0 {
                        cartModel.inProgressEmpty()
                    }
                }
            }
        }
    }
    
    //MARK: Task Group
    private func TaskGroup() -> some View {
        VStack(alignment: .leading){
            
            textView(text: "Task Groups (\(taskGroup.TaskGroup.count))", size: 18)
                .foregroundColor(BackgroundMode().textColor())
                .padding()
            
            ScrollView(.vertical, showsIndicators: false){
                VStack{
                    ForEach(taskGroup.TaskGroup, id: \.self){ taks in
                        cartModel.getTaskGroup(model: taks)
                    }
                }
            }
        }
    }
}

//#Preview {
//    HomePageView(user:)
//}
