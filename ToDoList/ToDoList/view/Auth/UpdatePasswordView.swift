//
//  UpdatePasswordView.swift
//  ToDoList
//
//  Created by bakebrlk on 27.02.2024.
//

import SwiftUI

struct UpdatePasswordView: View {
    @EnvironmentObject var navigate: Navigation

    @State private var email: String = ""
    
    var body: some View {
        
            GeometryReader{ make in
                VStack {
                    Spacer()
                    image
                    
                    emailView
                        .frame(maxWidth: .infinity, maxHeight: make.size.height/10)
    
                    updatePassword
                        .frame(maxHeight: make.size.height/10)
                    Spacer()
                }
            
        }
       
    }
        
}

extension UpdatePasswordView {
    private var emailView: some View {
        CustomTextField(text: $email, isSecure: false, titleKey: "email: ", haveSecure: false)
    }
    
    private var image: some View {
        Image("signin")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .padding()
    }
    
    private var updatePassword: some View {
        Button(
            action: {
                if !email.isEmpty {
                    Authentication.resendPassword(email: email)
                    try? Authentication.signOut()
                    navigate.navigateTo(.sendMail)

                }else{
                    print("-")
                }
                
        }, label: {
            textView(text: "Update Password", size: 22)
        })
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("purple"))
        .foregroundColor(.white)
        .cornerRadius(16)
        .padding()
    }
}

#Preview {
    UpdatePasswordView()
}
