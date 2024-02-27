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
    
    static func signIn() -> Bool{
        return true
    }
}
