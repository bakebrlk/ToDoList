//
//  BackgroundMode.swift
//  ToDoList
//
//  Created by bakebrlk on 20.03.2024.
//

import SwiftUI

final class BackgroundMode: ObservableObject {
    @AppStorage("isDarkMode") public var isDark = false
    
    public func textColor() -> Color {
        withAnimation{
            return isDark ? .white : .black
        }
    }
    
    public func viewBack() -> Color {
        withAnimation{
            return isDark ? Color(red: 0.129, green: 0.129, blue: 0.141) : Color(red: 0.922, green: 1, blue: 1)
        }
    }
    
    public func avtorColor() -> Color {
        withAnimation {
            return BackgroundMode().isDark ? .yellow : Color("purple")
        }
    }
}
