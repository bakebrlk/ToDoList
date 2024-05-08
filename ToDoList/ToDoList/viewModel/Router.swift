//
//  Router.swift
//  ToDoList
//
//  Created by bakebrlk on 27.02.2024.
//

import SwiftUI

enum Router{
    
    case welcome
    case checkAccount
    case singIn
    case signUp
    case updatePassword
    case sendMail
    case splashScreen
    case chat
    
    @ViewBuilder
    var builder: some View {
        switch(self) {
        case .welcome: WelcomePageView()
        case .checkAccount: CheckAccountView()
        case .singIn: SignInView()
        case .signUp: SignUpView()
        case .updatePassword: UpdatePasswordView()
        case .sendMail: SendMailView()
        case .splashScreen: SplashScreen()
        case .chat: ChatView()
        }
    }
}
