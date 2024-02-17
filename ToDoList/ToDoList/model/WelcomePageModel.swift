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
    
    private var imageView: Image {
        Image(imageName)
    }
    
    var body: some View {
        VStack {
            titleView
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
