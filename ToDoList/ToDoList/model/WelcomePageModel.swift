//
//  WelcomePageModal.swift
//  ToDoList
//
//  Created by bakebrlk on 17.02.2024.
//

import SwiftUI

struct WelcomePageModel: View{
    
    @State private var id: Int = 0
    @State private var title: String = ""
    @State private var desciption = ""
    @State private var imageName = ""
    
    @State private var titleView = Text("")
    
    @State private var descriptionView = Text("")
    
    @State private var imageView = Image("")
    
    var body: some View {
        VStack {
            imageView
                .padding()
            titleView
                .padding()
            descriptionView
        }
        .onAppear{
            reloadData()
        }
    }
}

extension WelcomePageModel {
    private func reloadData(){
        title = Data.WelcomePage.data[id].title
        desciption = Data.WelcomePage.data[id].description
        imageName = Data.WelcomePage.data[id].imageName
        
        titleView = textView(text: title, font: .title)
        descriptionView = textView(text: desciption, font: .largeTitle)
        imageView = Image(imageName)
            
    }
}

extension WelcomePageModel {
    func textView(text: String, font: Font) -> Text{
        Text(text)
            .font(font)
    }
}


#Preview {
    WelcomePageModel()
}
