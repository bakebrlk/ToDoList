//
//  CustomImage.swift
//  ToDoList
//
//  Created by bakebrlk on 01.03.2024.
//

import SwiftUI

final class CustomImage{
    static func getImage(imageName: String) -> some View {
        Image(imageName)
            .resizable()
            .aspectRatio(contentMode: .fit)
    }
    
    static func getImage(systemName: String) -> some View {
        Image(systemName: systemName)
            .resizable()
            .aspectRatio(contentMode: .fit)
    }
    
    static func getImage(uiImage: UIImage, height: CGFloat) -> some View {
        VStack{
            Image(uiImage: uiImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
        }
        .frame(maxWidth: height, maxHeight: height)
        .cornerRadius(height/2)
    }
}
