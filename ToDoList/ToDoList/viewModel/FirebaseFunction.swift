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
import FirebaseStorage

@MainActor
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
            "avatar": userModel.photoUrl ?? "https://firebasestorage.googleapis.com/v0/b/todolist-50fbf.appspot.com/o/checkAcc.png?alt=media&token=b17db4f2-27c3-4c8d-9ca2-69a44dc4df68"
        ]
        
        if let email = userModel.email {
            userData["email"] = email
        }
        
        if let photoUrl = userModel.photoUrl{
            userData["photoUrl"] = photoUrl
        }
        
        try await Firestore.firestore().collection("usersProfile").document(userModel.uid).setData(userData,merge: false)
    }
    
    static func getUserInfo(userId: String) async throws -> UserModel{
        let snapshot = try await Firestore.firestore().collection("usersProfile").document(userId).getDocument()
        
        guard let data = snapshot.data() else {
            throw URLError(.badServerResponse)
        }
        
        let nickName = data["name"] ?? "load"
        let email = data["email"] ?? "load"
        let photoUrl = data["avatar"] ?? "load"
        
        return UserModel(id: userId, name: nickName as! String, email: email as! String, avatarURL: photoUrl as! String)
    }
    
    static func updateUser(userId: String, nickName: String) async throws{
        let data: [String: Any] = [
            "name" : nickName
        ]
        
        try await Firestore.firestore().collection("usersProfile").document(userId).updateData(data)
    }
    
    static func updateUserAvatar(userId: String, path: String) async throws{
        let data: [String: Any] = [
            "avatar" : path
        ]
        
        try await Firestore.firestore().collection("usersProfile").document(userId).updateData(data)
    }
    
//MARK: Storage
    private static let storage = Storage.storage().reference()
    
    private static var imagesReference: StorageReference {
        storage.child("images")
    }
    
    private static func userReference(userId: String) -> StorageReference {
        storage.child("usersProfile").child(userId)
    }
    
    
    public static func saveImage(data: Foundation.Data, userId: String) async throws -> (path: String, name: String){
    
        let meta = StorageMetadata()
        meta.contentType = "image/jpeg"
        
        let path = "\(UUID().uuidString).jpeg"
        let returnedMetaData = try await userReference(userId: userId).child(path).putDataAsync(data, metadata: meta)
        
        guard let returnedPath = returnedMetaData.path, let returnedName = returnedMetaData.name else {
            throw URLError(.badServerResponse)
        }
        
        return (returnedPath, returnedName)
    }
    
    public static func getDataImage(userId: String, path: String) async throws -> Foundation.Data {
        try await storage.child(path).data(maxSize: 3 * 1024 * 1024)
    }
    
// MARK: Tasks
    
//    @StateObject static var db = TaskData()
    
    public static func createTask(userID: String, model: TaskModel) async throws {
        let taskData: [String: Any] = [
            "title": model.title,
            "description": model.description,
            "status": model.status.builder,
            "time": model.time,
            "taskGroupTitle" : model.taskGroup.title
        ]
        
        try await Firestore.firestore().collection("usersTasks").document(userID).collection("list").addDocument(data: taskData) 
    }
    
    public static func getTask(userID: String) async throws -> [TaskModel]{
        let snapshots = try await Firestore.firestore().collection("usersTasks").document(userID).collection("list").getDocuments().documents

        var tasks: [TaskModel] = []
        
        for i in 0..<snapshots.count{
            let data = snapshots[i]
            
            guard let timestamp = data["time"] as? Timestamp else {
                print("Invalid Timestamp for document ID: \(snapshots[i].documentID)")
                continue
            }
            
            let DataDate = date(from: timestamp)
           
            tasks.append(TaskModel(id: "\(data.documentID)",title: data["title"] as! String, description: data["description"] as! String, status: status(status: data["status"] as! String), time: DataDate, taskGroup: getTaskGroup(title: data["taskGroupTitle"] as! String)))
        }
        
        return tasks
    }
    
    private static func getTaskGroup(title: String) -> TaskGroupModel {
        for group in Data.Tasks().TaskGroup {
            if group.title == title {
                return group
            }
        }
        
        return Data.Tasks().TaskGroup[0]
    }
    
    private static func status(status: String) -> TaskStatus{
        if status == "To do" {
            return .toDo
        }else if status == "Done"{
            return .done
        }else if status == "In Process"{
            return .inProcess
        }
        return .all
    }

    private static func date(from timestamp: Timestamp) -> Date {
        let seconds = TimeInterval(timestamp.seconds)
        let date = Date(timeIntervalSince1970: seconds)
        
        return date
    }
    
    static func updateTask(userId: String, taskID: String, title: String?, description: String?, status: TaskStatus?) {
        var data: [String: Any] = [:]
        
        if let title = title {
            data["title"] = title
        }
        
        if let description = description {
            data["description"] = description
        }
        
        if let status = status {
            data["status"] = status.builder
        }
        
        Firestore.firestore().collection("usersTasks").document(userId).collection("list").document(taskID).updateData(data)
            
    }
    
    static func deleteTask(userId: String, taskID: String) async throws{
        try await Firestore.firestore().collection("usersTasks").document(userId).collection("list").document(taskID).delete()
    }
    
}

