//
//  User.swift
//  Taskly
//
//  Created by bakebrlk on 13.04.2024.
//
import SwiftUI

@MainActor
final class UserResponse: ObservableObject{
    
    @Published var user: UserModel? = nil
    
    init(){
        Task{
            try await userInfo()
        }
    }
    public func userInfo() async throws{
        let authDataResult = try FirebaseFunction.getAuthenticatedUser()
        let userInfo = try await FirebaseFunction.getUserInfo(userId: authDataResult.uid)
                
        self.user = userInfo
    }
    
    public func editUser(nick: String) async throws{
        try await FirebaseFunction.updateUser(userId: user!.id, nickName: nick)
        let updateUser = try await FirebaseFunction.getUserInfo(userId: user!.id)
        
        DispatchQueue.main.async {
            self.user = updateUser
        }
    }
}
