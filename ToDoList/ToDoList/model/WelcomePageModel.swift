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
    
    private var nextPage: some View {
        
        
            Button(
                action: {
                    id += 1
                    reloadData()
                },
                label: {
                    
                    HStack{

                        Spacer()
                        textView(text: "Let's Start", font: .system(.title3, weight: .bold))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.leading)
                                                
                        Spacer()

                        textView(text: "->", font: .system(.title3, weight: .bold))
                            .foregroundColor(.white)
                            .padding(.trailing)
                    }
            })
        
        
        
    }
    
    var body: some View {
        
        GeometryReader { make in
            
            VStack {
                Spacer()
                
                imageView
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding()
                
                Spacer()
                
                titleView
                    .multilineTextAlignment(.center)
                    .padding()
                
                descriptionView
                    .multilineTextAlignment(.center)
                    .padding()
                Spacer()
                
                nextPage
                    .frame(maxWidth: .infinity, maxHeight: make.size.height/10)
                    .background(Color.purple)
                    .cornerRadius(18)
                    .padding()
            }
            .onAppear{
                reloadData()
            }
        }
    }
}

extension WelcomePageModel {
    private func reloadData(){
        title = Data.WelcomePage.data[id].title
        desciption = Data.WelcomePage.data[id].description
        imageName = Data.WelcomePage.data[id].imageName
        
        titleView = textView(text: title, font: .system(size: 36, weight: .medium))
        descriptionView = textView(text: desciption, font: .system(size: 22, weight: .thin))
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
