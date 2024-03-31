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
    @State private var selectedImage = UIImage(named: "checkAcc")
    
    @Binding public var checkPresent: Bool
    
    @StateObject public var user: Data.User
    @Binding public var avatarData: Foundation.Data?

    var body: some View {
        VStack{
            avatar(height: Size.size[1]/4)
            nickNameView
            btn
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(BackgroundMode().viewBack())
        .task {
            if let user = user.user {
                let newData = try? await FirebaseFunction.getDataImage(userId: user.id, path: user.avatarURL)
                
                selectedImage = UIImage(data: newData ?? Foundation.Data())
            }
        }
    }
}

extension EditProfileView{
    
    private func avatar(height: CGFloat) -> some View {
        Button {
            isImagePickerPresented.toggle()
        } label: {
            CustomImage.getImage(uiImage: selectedImage!, height: height/1.1)
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
            .autocorrectionDisabled()
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
            saveProfileImage(image: selectedImage!)

            Task{
                
                if !nickName.isEmpty {
                    try await user.editUser(nick: nickName)
                }
                
            }
            checkPresent.toggle()
            
        }, label: {
           textView(text: "Save", size: 18)
                .foregroundColor(.white)
        })
        .frame(maxWidth: .infinity, maxHeight: Size.size[1]/18)
        .background(Color("purple"))
        .cornerRadius(20)
        .padding()
    }
    
//MARK: save Image
    private func saveProfileImage(image: UIImage) {
                
        Task{
            guard let data = image.jpegData(compressionQuality: 0.5) else {
                return
            }
            
            let (path,name) = try await FirebaseFunction.saveImage(data: data, userId: user.user?.id ?? "")
            print(path)
            print(name)
            print("Success!")
            
            try await FirebaseFunction.updateUserAvatar(userId: user.user?.id ?? "", path: path)
            
            do {
                try? await user.userInfo()
                
                if let user = user.user {
                    avatarData = try? await FirebaseFunction.getDataImage(userId: user.id, path: user.avatarURL)
                    selectedImage = UIImage(data: avatarData ?? Foundation.Data())
                    print(user.avatarURL)
                }
            }
        }
    }
}

#Preview {
    EditProfileView(checkPresent: .constant(true), user: Data.User(), avatarData: .constant(Foundation.Data()))
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

