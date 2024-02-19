//
//  SignUpView.swift
//  ToDoList
//
//  Created by bakebrlk on 19.02.2024.
//

import Foundation
import SwiftUI

struct SignUpView: View {
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confpassword: String = ""
    
    var body: some View{
        GeometryReader{ make in
            VStack {
                Spacer()
                image
                
                emailView
                    .frame(maxWidth: .infinity, maxHeight: make.size.height/10)
                passwordView
                    .frame(maxWidth: .infinity, maxHeight: make.size.height/10)
                confpasswordView
                    .frame(maxWidth: .infinity, maxHeight: make.size.height/10)

                HStack{
                    Spacer()
                    signIn
                }
                signUp
                    .frame(maxHeight: make.size.height/10)
                Spacer()
            }
        }
    }
}

extension SignUpView{
    
    private var emailView: some View {
        CustomTextField(text: $email, isSecure: false, titleKey: "Email: ", haveSecure: false)
    }
    
    private var passwordView: some View {
        CustomTextField(text: $password, isSecure: true, titleKey: "password: ", haveSecure: true)
    }
    
    private var confpasswordView: some View {
        CustomTextField(text: $confpassword, isSecure: true, titleKey: "confirm password: ", haveSecure: true)
    }
    private var image: some View {
        Image("signup")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .padding()
    }
    
    private var signUp: some View {
        Button(
            action: {
                if ToDoList.signIn(email: email, password: password) {
                    print("succes")
                }
        }, label: {
            textView(text: "Sign Up", size: 22)
        })
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("purple"))
        .foregroundColor(.white)
        .cornerRadius(16)
        .padding()
    }
    
    private var signIn: some View {
        Button(
            action: {
            print("Sign In")
        }
            , label: {
            textView(text: "Sign In", size: 16)
        })
        .foregroundColor(.orange)
        .padding(.trailing)
    }
}

#Preview {
    SignUpView()
}
