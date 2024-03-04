//
//  SendMailView.swift
//  ToDoList
//
//  Created by bakebrlk on 27.02.2024.
//

import SwiftUI

struct SendMailView: View {
    var body: some View {
        NavigationView {
            GeometryReader { make in
                VStack{
                    
                    image
                    
                    btn(height: make.size.height/14)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .navigationTitle("Send Email")
        }
    }
}

extension SendMailView {
    
    private var image: some View {
        Image("emailLogo")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .cornerRadius(16)
            .padding()
    }
    
    private func btn(height: CGFloat) -> some View {
        customButton(text: "Sign In", action: action())
            .background(Color("purple"))
            .foregroundColor(.white)
            .cornerRadius(20)
            .padding()
    }
    
    private func action(){
        
    }
}

#Preview {
    SendMailView()
}
