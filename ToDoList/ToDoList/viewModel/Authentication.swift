//
//  Auth.swift
//  ToDoList
//
//  Created by bakebrlk on 27.02.2024.
//

import FirebaseAuth
import SwiftUI

struct Authentication{
    
    static func signUp(email: String, password: String, confPassword: String) -> Bool{
        
        guard !email.isEmpty && !password.isEmpty && confPassword == password && validPassword(password: password) else{
            return false
        }
        
        Task {
            do {
                let returnedUserData = try await FirebaseFunction.signUp(email: email, password: password)
                print(returnedUserData)
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
