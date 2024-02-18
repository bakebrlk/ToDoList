//
//  checkAccountView.swift
//  ToDoList
//
//  Created by bakebrlk on 19.02.2024.
//

import SwiftUI

struct CheckAccountView: View {
    
    var body: some View {
        
        VStack{
            
            welcomeText
            buttons
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.purple)
        
    }
}

extension CheckAccountView {
    
    private var welcomeText: some View {
        textView(text: "Welcome to the task management app", size: 32)
            .multilineTextAlignment(.center)
            .foregroundColor(.yellow)
    }
    
    private var buttons: some View {
        GeometryReader { make in
            VStack{
                customButton(text: "I've already account ", action: haveAccount())
                    .foregroundColor(.white)
                customButton(text: "Sign Up", action: signUp())
                    .frame(maxWidth: make.size.width, maxHeight: make.size.height/14)
                    .background(Color.white)
                    .foregroundColor(.black)
                    .cornerRadius(18)
                    .padding()
            }
        }
    }
}

extension CheckAccountView{
    
    private func haveAccount(){
        
    }
    
    private func signUp(){
        
    }
}

#Preview {
    CheckAccountView()
}
