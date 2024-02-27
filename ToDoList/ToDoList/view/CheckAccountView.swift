//
//  checkAccountView.swift
//  ToDoList
//
//  Created by bakebrlk on 19.02.2024.
//

import SwiftUI

struct CheckAccountView: View {
    
    var body: some View {
        NavigationView {
            GeometryReader { make in
                VStack{
                    Spacer()
                    welcomePhoto
                    Spacer()
                    welcomeText
                    
                    buttons
                        .frame(maxWidth: .infinity, maxHeight: make.size.height/5.5)
                    
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color("purple"))
            }
        }
        
    }
}

extension CheckAccountView {
    
    private var welcomePhoto: some View {
        Image("checkAcc")
            .resizable()
            .aspectRatio(contentMode: .fit)
    }
    
    private var welcomeText: some View {
        textView(text: "Welcome to the task management app", size: 32)
            .multilineTextAlignment(.center)
            .foregroundColor(.yellow)
    }
    
    private var buttons: some View {
         
        VStack{
            Spacer()
            NavigationLink(destination: SignInView()){
                customButton(text: "I've already account ", action: haveAccount())
                    .foregroundColor(.white)
            }
          
                customButton(text: "Sign Up", action: signUp())
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.white)
                    .foregroundColor(.black)
                    .cornerRadius(18)
                    .padding()
            
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
