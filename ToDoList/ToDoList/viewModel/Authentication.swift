//
//  Auth.swift
//  ToDoList
//
//  Created by bakebrlk on 27.02.2024.
//

import FirebaseAuth
import SwiftUI

struct Authentication{
    
    static func signUp(email: String, password: String, confPassword: String, nickName: String) -> Bool{
        
        guard !email.isEmpty && !password.isEmpty && confPassword == password && validPassword(password: password) && !nickName.isEmpty else{
            return false
        }
        
        Task {
            do {
                
                
                let returnedUserData = try await FirebaseFunction.signUp(email: email, password: password, nickName: nickName, photoUrl: URL(string: "https://firebasestorage.googleapis.com/v0/b/todolist-50fbf.appspot.com/o/checkAcc.png?alt=media&token=d7882cd9-8453-46c3-addd-4695e9eff4cc")!)
                print(returnedUserData)
                
                try await FirebaseFunction.createNewUser(userModel: returnedUserData)
                
                return true
            }catch {
                print(error)
                return false
            }
        }
        
        return true
    }
    
    static func signIn(email: String, password: String) -> Bool{
        
        Task{
            do{
                let returnedUserData = try await FirebaseFunction.signIn(email: email, password: password)
                print(returnedUserData)
                return true
            }catch{
                print("error")
                return false
            }
        }
        
        return true
        
    }
    
    static func checkAuthentication() -> Bool{
        let authUser = try? FirebaseFunction.getAuthenticatedUser()
        return authUser == nil
    }
    
    static func resendPassword(email: String) {
        DispatchQueue.main.async {
            Task {
                do{
                    try? await FirebaseFunction.resentPassword(email: email)
                }
            }
        }
    }
    
    static func updatePassword(password: String) -> Bool {
        DispatchQueue.main.async {
            Task{
                do{
                    try? await FirebaseFunction.updatePassword(password: password)
                    print("Update Password")
                    return true
                }
            }
        }
        
        return true
    }
    
    
    static func signOut() throws{
        try FirebaseFunction.signOut()
    }
}

extension Authentication {
    
    private static func validPassword(password: String) -> Bool {
        
        let uppercaseLetterRegex = ".*[A-Z]+.*"
        let lowercaseLetterRegex = ".*[a-z]+.*"
        let numberRegex = ".*[0-9]+.*"

        let uppercaseTest = NSPredicate(format:"SELF MATCHES %@", uppercaseLetterRegex)
        let lowercaseTest = NSPredicate(format:"SELF MATCHES %@", lowercaseLetterRegex)
        let numberTest = NSPredicate(format:"SELF MATCHES %@", numberRegex)

        return uppercaseTest.evaluate(with: password) &&
                      lowercaseTest.evaluate(with: password) &&
                      numberTest.evaluate(with: password)
    }
}
