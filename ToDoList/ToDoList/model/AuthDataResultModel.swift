//
//  AuthDataResultModel.swift
//  ToDoList
//
//  Created by bakebrlk on 27.02.2024.
//

import SwiftUI
import FirebaseAuth

struct AuthDataResultModel {
    let uid: String
    let email: String?
    let photoUrl: String?
    
    init(user: User){
        self.uid = user.uid
        self.email = user.email
        self.photoUrl = user.photoURL?.absoluteString
    }
}
