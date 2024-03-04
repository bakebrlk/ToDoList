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

func sizeStatus() -> Bool{
    return UserDefaults.standard.bool(forKey: "sizeStatus")
}

func setStatusSize(status: Bool) {
    UserDefaults.standard.setValue(status, forKey: "sizeStatus")
}

func setSize(width: CGFloat, height: CGFloat){
    UserDefaults.standard.setValue([width,height], forKey: "Size")
}

func getSize() -> [CGFloat]{
    return UserDefaults.standard.value(forKey: "Size") as! [CGFloat]
}
