//
//  StaticticRecrangle.swift
//  ToDoList
//
//  Created by bakebrlk on 04.03.2024.
//

import SwiftUI

struct RecrangleModel{
    @Binding var process: Double
    var color: Color
    
    public func statisticRectangle() -> some View{
        ZStack(alignment: .leading){
            Rectangle()
                .frame(maxWidth: .infinity, maxHeight: 5)
                .foregroundColor(Color.white)
                .background(Color.white)
            Rectangle()
                .frame(maxWidth: Size.size[0]*process*0.55, maxHeight: 5)
                .foregroundColor(color)
        }
        .cornerRadius(8)
    }
}
