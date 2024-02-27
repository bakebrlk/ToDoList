//
//  FirebaseFunction.swift
//  ToDoList
//
//  Created by bakebrlk on 20.02.2024.
//

import Foundation
import SwiftUI
import FirebaseAuth

struct FirebaseFunction{
    
    static let shared = FirebaseFunction()
    
    private init() {}
    
    static func signUp(email: String, password: String) async throws -> AuthDataResultModel{
        let authDataResult = try await Auth.auth().createUser(withEmail: email, password: password)
        return AuthDataResultModel(user: authDataResult.user)
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
}
