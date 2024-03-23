//
//  EditProfileView.swift
//  ToDoList
//
//  Created by bakebrlk on 23.03.2024.
//

import SwiftUI

struct EditProfileView: View {
    
    @State private var nickName = ""
    
    @State private var isImagePickerPresented = false
    @State private var selectedImage: UIImage?
    
    @Binding public var checkPresent: Bool
    
    var body: some View {
        VStack{
            avatar(height: Size.size[1]/4)
            nickNameView
            btn
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(BackgroundMode().viewBack())
    }
}

extension EditProfileView{
    
    private func avatar(height: CGFloat) -> some View {
        Button {
            isImagePickerPresented.toggle()
        } label: {
            if let image = selectedImage {
                CustomImage.getImage(uiImage: image, height: height/1.1)
            }else{
                CustomImage.getImage(imageName: "checkAcc")
            }
            
        }
        .sheet(isPresented: $isImagePickerPresented) {
            ImagePicker(selectedImage: $selectedImage, isImagePickerPresented: $isImagePickerPresented)
        }
        .frame(maxWidth: height, maxHeight: height)
        .cornerRadius(height/2)
    }
    
    private var nickNameView: some View {
        
        TextField("", text: $nickName)
            .placeholder(when: nickName.isEmpty) {
            Text("nick name: ")
                    .foregroundColor(BackgroundMode().isDark ? .white.opacity(0.6) : .gray)
            }
            .frame(maxWidth: .infinity, maxHeight: Size.size[1]/16)
            .foregroundColor(BackgroundMode().textColor())
            .padding([.leading,.trailing])
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color(.systemGray))
            )
            .padding()

    }
    
    private var btn: some View {
        Button(action: {
            checkPresent.toggle()
        }, label: {
           textView(text: "Save", size: 18)
                .foregroundColor(BackgroundMode().textColor())
        })
        .frame(maxWidth: .infinity, maxHeight: Size.size[1]/18)
        .background(Color("purple"))
        .cornerRadius(20)
        .padding()
    }
}

#Preview {
    EditProfileView(checkPresent: .constant(true))
}


extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {
            
        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}

