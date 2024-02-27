//
//  NavigationModifire.swift
//  ToDoList
//
//  Created by bakebrlk on 27.02.2024.
//

import SwiftUI

struct NavigationModifire: ViewModifier {
    
    @State var isActive = true
    
    @Binding var route: Router
    
    func body(content: Content) -> some View {
        content
            .background{
                NavigationLink(destination: route.builder, isActive: $isActive){
                    WelcomePageView()
                }.hidden()
            }
            .onChange(of: isActive){
                if $0 == false {route = .welcome}
            }
    }
}
