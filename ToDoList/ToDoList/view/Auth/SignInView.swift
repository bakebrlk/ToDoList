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
    
    @State private var signInStatus = false
    
    @EnvironmentObject var navigate: Navigation

    private var timer = Timer.publish(every: 5, on: .main, in: .common).autoconnect()
    
    var body: some View {
       
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
                        .frame(maxHeight: make.size.height/8)
                    Spacer()
                }
                .navigationTitle("Welcome to Back")
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
 
                Authentication.signIn(email: email, password: password)
        }, label: {
            textView(text: "Sign In", size: 22)
        })
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("purple"))
        .foregroundColor(.white)
        .cornerRadius(16)
        .padding()
        .onReceive(timer) { [self] _ in
            navigationStatus()
        }
    }
    
    private func navigationStatus(){
    
        Task{
            if !Authentication.checkAuthentication(){
                self.timer.upstream.connect().cancel()
                navigate.navigateTo(.tabBar)
            }else{
                print("No account")
            }
        }
    }
    
    private var signUp: some View {
        Button(
            action: {
                navigate.navigateTo(.updatePassword)
        }
            , label: {
            textView(text: "Forgot password", size: 16)
        })
        .foregroundColor(.orange)
        .padding([.trailing,.top])
    }
    
}

#Preview {
    SignInView()
}
