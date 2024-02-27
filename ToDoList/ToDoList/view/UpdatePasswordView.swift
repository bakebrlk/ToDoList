//
//  UpdatePasswordView.swift
//  ToDoList
//
//  Created by bakebrlk on 27.02.2024.
//

import SwiftUI

struct UpdatePasswordView: View {
    
    let email: String
    @State private var password: String = ""
    @State private var confPassword: String = ""
    
    var body: some View {
        NavigationView{
            GeometryReader{ make in
                VStack {
                    Spacer()
                    image
                    
                    passwordView
                        .frame(maxWidth: .infinity, maxHeight: make.size.height/10)
                    confPasswordView
                        .frame(maxWidth: .infinity, maxHeight: make.size.height/10)
                    
                    updatePassword
                        .frame(maxHeight: make.size.height/10)
                    Spacer()
                }
            }
        }
    }
        
}

extension UpdatePasswordView {
    private var passwordView: some View {
        CustomTextField(text: $password, isSecure: true, titleKey: "password: ", haveSecure: true)
    }
    
    private var confPasswordView: some View {
        CustomTextField(text: $confPassword, isSecure: true, titleKey: "confirm password: ", haveSecure: true)
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
                if Authentication.signIn(email: email, password: password) {
                    print("succes")
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
    UpdatePasswordView(email: "bake")
}
