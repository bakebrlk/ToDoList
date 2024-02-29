//
//  StatisticsCircleModel.swift
//  ToDoList
//
//  Created by bakebrlk on 01.03.2024.
//

import SwiftUI

struct StatisticsCircleModel {
    
    @Binding var proces: Double
}

extension StatisticsCircleModel {
    private func getCircle(strokeLineWidth: CGFloat, width: CGFloat, height: CGFloat) -> some View {
        Circle()
            .stroke(lineWidth: strokeLineWidth)
            .frame(width: width, height: height)
    }
    
    private func statisticsCircles(width: CGFloat, height: CGFloat) -> some View {
        ZStack{
            getCircle(strokeLineWidth: 24, width: width, height: height)
                .foregroundColor(.white)
                .shadow(color: .black.opacity(0.1), radius: 10, x: 10, y: 10)
            
            getCircle(strokeLineWidth: 0.34, width: width/1.14, height: height/1.14)
                .foregroundStyle(LinearGradient(gradient: Gradient(colors: [.black.opacity(0.3),.clear]), startPoint: .bottomTrailing, endPoint: .topLeading))
                .overlay {
                    Circle()
                        .stroke(.black.opacity(0.1), lineWidth: 2)
                        .blur(radius: 5)
                        .mask {
                            Circle()
                                .foregroundStyle(LinearGradient(gradient: Gradient(colors: [.black, .clear]), startPoint: .topLeading, endPoint: .bottomTrailing))
                        }
                }
            
            Circle()
                .trim(from: 0, to: proces)
                .stroke(style: StrokeStyle(lineWidth: 24, lineCap: .round))
                .frame(width: width, height: height)
                .rotationEffect(.degrees(-90))
                .foregroundStyle(LinearGradient(gradient: Gradient(colors: [Color.purple, Color.blue]), startPoint: .topLeading, endPoint: .bottomTrailing))
            
            textView(text: "\(Int(proces*100))%", size: 28)
        }
        .onAppear {
            withAnimation {
                proces = 0.1
            }
        }
        
    }
}

