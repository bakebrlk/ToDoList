//
//  CalendarModel.swift
//  ToDoList
//
//  Created by bakebrlk on 06.03.2024.
//

import SwiftUI

struct CalendarModel{
    
    public static let shared = CalendarModel()
    
    public func forCalendarPage(date: Date) -> some View {
        VStack{
            textView(text: month(currentDate: date), size: 12)
            textView(text: dayOfMonth(currentDate: date), size: 16)
                .padding(1)
            textView(text: dayOfWeek(currentDate: date), size: 12)
        }
        .frame(width: Size.size[0]/5.4, height: Size.size[1]/9)
        .background(Color.white)
        .cornerRadius(16)
    }
    
    public func time(currentDate: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        return dateFormatter.string(from: currentDate)
    }
    
    private func month(currentDate: Date) -> String {
        let calendar = Calendar.current
        let month = calendar.component(.month, from: currentDate)
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US")
        return formatter.monthSymbols[month - 1]
    }
    
    private func dayOfMonth(currentDate: Date) -> String {
        let calendar = Calendar.current
        let day = calendar.component(.day, from: currentDate)
        return "\(day)"
    }
    
    private func dayOfWeek(currentDate: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E"
        return dateFormatter.string(from: currentDate)
    }
}
