//
//  CheckWelcomePage.swift
//  ToDoList
//
//  Created by bakebrlk on 19.02.2024.
//

import Foundation
import SwiftUI

func statusWelcomePage() -> Bool {
    return UserDefaults.standard.bool(forKey: "WelcomePage")
}

func setStatusWelcomePage(status: Bool){
    UserDefaults.standard.setValue(status, forKey: "WelcomePage")
}
