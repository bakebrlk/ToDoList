//
//  FirebaseFunction.swift
//  ToDoList
//
//  Created by bakebrlk on 20.02.2024.
//

import Foundation
import SwiftUI
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

struct FirebaseFunction{
            
    static func signUp(email: String, password: String, nickName: String) async throws -> AuthDataResultModel{
        let authDataResult = try await Auth.auth().createUser(withEmail: email, password: password)
        
        let changeRequest = authDataResult.user.createProfileChangeRequest()
           changeRequest.displayName = nickName
           
        do {
               try await changeRequest.commitChanges()
               print(authDataResult.user.displayName ?? " aaa ")
               return AuthDataResultModel(user: authDataResult.user)
           } catch {
               throw error
           }
    }
    
    @discardableResult
    static func signIn(email: String, password: String) async throws -> AuthDataResultModel{
        let authDataResult = try await Auth.auth().signIn(withEmail: email, password: password)
        return AuthDataResultModel(user: authDataResult.user)
    }
    
    @discardableResult
    static func getAuthenticatedUser()throws -> AuthDataResultModel {
        guard let user = Auth.auth().currentUser else {
            throw URLError(.badServerResponse)
        }
        
        return AuthDataResultModel(user: user)
    }
    
    static func signOut() throws{
        try Auth.auth().signOut()
    }
    
    
    static func resentPassword(email: String) async throws {
        try await Auth.auth().sendPasswordReset(withEmail: email)
    }
    
    static func updatePassword(password: String) async throws{
        guard let user = Auth.auth().currentUser else {
            throw URLError(.badServerResponse)
        }
        
        try await user.updatePassword(to: password)
    }
    
    static func createNewUser(userModel: AuthDataResultModel) async throws {
        var userData: [String: Any] = [
            "id": userModel.uid,
            "name": userModel.name,
//            "db": DataModel()
        ]
        
        if let email = userModel.email {
            userData["email"] = email
        }
        
        if let photoUrl = userModel.photoUrl{
            userData["photoUrl"] = photoUrl
        }
        
        try await Firestore.firestore().collection("users").document(userModel.uid).setData(userData,merge: false)
    }
    
    static func getUserInfo(userId: String) async throws -> UserModel{
        let snapshot = try await Firestore.firestore().collection("users").document(userId).getDocument()
        
        guard let data = snapshot.data() else {
            throw URLError(.badServerResponse)
        }
        
        let nickName = data["name"] ?? "load"
        let email = data["email"] ?? "load"
        let photoUrl = data["photoUrl"] ?? "load"
        
        return UserModel(id: userId, name: nickName as! String, email: email as! String)
    }
}
