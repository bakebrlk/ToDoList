//
//  SignInView.swift
//  ToDoList
//
//  Created by bakebrlk on 19.02.2024.
//

import SwiftUI

struct SignInView: View {
    
    @State private var email = ""
    @State private var password = ""
    
    var body: some View {
        NavigationView {
            GeometryReader{ make in
                VStack {
                    Spacer()
                    image
                    
                    emailView
                        .frame(maxWidth: .infinity, maxHeight: make.size.height/10)
                    passwordView
                        .frame(maxWidth: .infinity, maxHeight: make.size.height/10)
                    
                    HStack{
                        Spacer()
                        signUp
                    }
                    signIn
                        .frame(maxHeight: make.size.height/10)
                    Spacer()
                }
            }
        }
    }
}

extension SignInView {
    
    private var emailView: some View {
        CustomTextField(text: $email, isSecure: false, titleKey: "Email: ", haveSecure: false)
    }
    
    private var passwordView: some View {
        CustomTextField(text: $password, isSecure: true, titleKey: "password: ", haveSecure: true)
    }
    
    private var image: some View {
        Image("signin")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .padding()
    }
    
    private var signIn: some View {
        Button(
            action: {
                if Authentication.signIn(email: email, password: password) {
                    print("succes")
                }
        }, label: {
            textView(text: "Sign In", size: 22)
        })
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("purple"))
        .foregroundColor(.white)
        .cornerRadius(16)
        .padding()
    }
    
    private var signUp: some View {
        Button(
            action: {
        }
            , label: {
            textView(text: "Forgot password", size: 16)
        })
        .foregroundColor(.orange)
        .padding(.trailing)
    }
    
}

#Preview {
    SignInView()
}
