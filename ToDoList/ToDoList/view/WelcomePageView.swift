//
//  WelcomePageModal.swift
//  ToDoList
//
//  Created by bakebrlk on 17.02.2024.
//

import SwiftUI

struct WelcomePageView: View{
    
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
                        Text("Let's Start")  
                            .font( .system(.title3, weight: .bold))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.leading)
                                                
                        Spacer()
                        
                        textView(text: "->", weight: .bold, size: 22)
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
                    .foregroundColor(Color(red: 0.43, green: 0.416, blue: 0.486))
                    .padding()
                Spacer()
                
                nextPage
                    .frame(maxWidth: .infinity, maxHeight: make.size.height/12)
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

extension WelcomePageView {
    private func reloadData(){
        title = Data.WelcomePage.data[id].title
        desciption = Data.WelcomePage.data[id].description
        imageName = Data.WelcomePage.data[id].imageName
        
        titleView = textView(text: title, weight: .bold, size: 34)
        descriptionView = textView(text: desciption, weight: .thin, size: 18)
        
        imageView = Image(imageName)
            
    }
}

extension WelcomePageView {
    func textView(text: String, weight: Font.Weight, size: CGFloat)-> Text{
        Text(text)
            .fontWeight(weight)
            .font(.custom("LexendDeca-Regular", size: size))
            
            
    }
}


#Preview {
    WelcomePageView()
}
