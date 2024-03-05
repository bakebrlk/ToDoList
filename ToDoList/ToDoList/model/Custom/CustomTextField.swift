//
//  CustomTextField.swift
//  ToDoList
//
//  Created by bakebrlk on 19.02.2024.
//

import Foundation
import SwiftUI

struct CustomTextField: View {
  
    @Binding var text: String
    @State var isSecure: Bool
    var titleKey: String
    var haveSecure: Bool
    
    var body: some View {
        GeometryReader { make in
            HStack{
                Group {
                    if isSecure {
                        SecureField(titleKey, text: $text)
                    }else{
                        TextField(titleKey, text: $text)
                    }
                }
                .animation(.easeInOut(duration: 0.2), value: isSecure)
                .font(.custom("LexendDeca-Regular", size: 18))
                .autocorrectionDisabled()
                .padding()
                
                if haveSecure {
                    Button(
                        action: {
                            isSecure.toggle()
                        },
                        label: {
                            Group{
                                if isSecure {
                                    Image(systemName: "eye.slash")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                }else{
                                    Image(systemName: "eye")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                }
                            }
                            .foregroundColor(Color.gray)
                            .padding()
                    })
                    .frame(maxWidth: make.size.width/6, maxHeight: make.size.height/1.6)
                    
                }
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.init(uiColor: UIColor.systemGray6))
            .cornerRadius(16)
            .padding()
        }
        
    }
}

