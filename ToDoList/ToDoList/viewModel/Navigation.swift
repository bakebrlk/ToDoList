//
//  Navigation.swift
//  ToDoList
//
//  Created by bakebrlk on 27.02.2024.
//

import SwiftUI

final class Navigation: ObservableObject{
    @Published var path: NavigationPath = NavigationPath()
    
    func navigateTo(_ appRoute: Router) {
        path.append(appRoute)
    }
       
    func navigateBack() {
        path.removeLast()
    }
       
    func popToRoot() {
        path.removeLast(path.count)
    }
}
