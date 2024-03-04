//
//  UpdatePasswordView.swift
//  ToDoList
//
//  Created by bakebrlk on 27.02.2024.
//

import SwiftUI

struct UpdatePasswordView: View {
    
    let email: String = "210103194@stu.sdu.edu.kz"
    @State private var password: String = ""
    @State private var confPassword: String = ""
    
    var body: some View {
        NavigationView{
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
        .fullScreenCover(isPresented: .constant(true), content: {
            SendMailView()
        })
    }
        
}

extension UpdatePasswordView {
    private var emailView: some View {
        CustomTextField(text: $password, isSecure: false, titleKey: "email: ", haveSecure: false)
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
                if password == confPassword {
                    Authentication.resendPassword(email: email)
                    try? Authentication.signOut()
                   
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
