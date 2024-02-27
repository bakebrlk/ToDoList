//
//  View.swift
//  ToDoList
//
//  Created by bakebrlk on 27.02.2024.
//

import SwiftUI

extension View{
    
    @ViewBuilder
    func navigation(route: Binding<Router>) -> some View {
        modifier(NavigationModifire(route: route))
    }
}
