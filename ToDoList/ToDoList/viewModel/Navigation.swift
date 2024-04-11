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
        DispatchQueue.main.async {
            self.path.append(appRoute)
        }
    }
        
    func navigateBack() {
        DispatchQueue.main.async {
            self.path.removeLast()
        }
    }
        
    func popToRoot() {
        DispatchQueue.main.async {
            self.path.removeLast(self.path.count)
        }
    }
}
