//
//  SplashScreen.swift
//  Taskly
//
//  Created by bakebrlk on 13.04.2024.
//

import SwiftUI

struct SplashScreen: View {
    
    @State private var isActive = false
    @State private var size = 0.4
    @State private var opacity = 0.5
    
    @StateObject public var user = UserResponse()
    @StateObject var db = TaskData()
    @StateObject var tasksGroup = Data.Tasks()
    @StateObject var backMode = BackgroundMode()
    @State private var avatarData: Foundation.Data? = nil

    var body: some View {
        VStack{
            if isActive{
                CustomTabBar(backgroundMode: backMode, user: user, db: db, avatarData: $avatarData, taskGroup: tasksGroup)
                    .padding([.leading, .trailing])
            }else{
                VStack{
                    Image("checkAcc")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        
                    textView(text: "Taskly", size: 26)
                        .foregroundColor(.white)
                }
                .frame(maxWidth: 250, maxHeight: 250)
                .scaleEffect(size)
                .opacity(opacity)
                .onAppear{
                    withAnimation(.easeIn(duration: 1.2)){
                        self.size = 1.2
                        self.opacity = 1.0
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3.0){
                        isActive.toggle()
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("purple"))
        .task {
            Task {
                print("SplashScreen")
                do {
                    try await user.userInfo()
                    if let user = user.user{
                        db.setUser(user: user)
                        db.setTaskGroup(tasksGroup)
                        try await db.appendTasks(userID: user.id)
                        avatarData = try? await FirebaseFunction.getDataImage(userId: user.id, path: user.avatarURL)
                        db.Task.sort { $0.time < $1.time }
                    }else{
                        print("User == nil")
                    }
                    
                    
                } catch {
                    print("Error fetching user info: \(error)")
                }

            }
        }
    }
}

