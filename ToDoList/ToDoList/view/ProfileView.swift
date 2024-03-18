//
//  ProfileView.swift
//  ToDoList
//
//  Created by bakebrlk on 17.03.2024.
//

import SwiftUI

struct ProfileView: View {
    
    @State private var isImagePickerPresented = false
    @State private var selectedImage: UIImage?
    @State private var isBackgroundModew = false
        
    @StateObject private var user = Data.User()
    
//MARK: Body
    var body: some View {
        VStack{
            navBar
            Spacer()
            avatar(height: Size.size[1]/3)
            
            settings
            
            Spacer()
            
            textView(text: "Taskly!", size: 32)
                .foregroundColor(Color("purple"))
                .padding(.bottom)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.cyan.opacity(0.1))
        
        .task {
            try? await user.userInfo()
        }
    }
}

extension ProfileView{
//MARK: Nav Bar
    private var navBar: some View {
        NavigationTopBar(title: "Profile", backAction: ())
    }
    
//MARK: Image Picker
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

//MARK: Settings and User Information
    private var settings: some View {
        VStack{
            userInfo(title: "nick name: ", description: user.user?.name ?? "user")
            userInfo(title: "email: ", description: user.user?.email ?? "user@gmail.com")
            backgroundSwitch
            editProfile
            signOut
        }
        .background(Color.white)
        .cornerRadius(20)
        .padding([.leading, .trailing],40)    }
    
//MARK: User Info
    private func userInfo(title: String, description: String) -> some View {
        VStack{
            HStack{
                textView(text: title, size: 14)
                    .padding(.leading)
                Spacer()
                
                textView(text: description, size: 14)
                    .padding(.trailing)
            }
            
            Rectangle()
                .frame(maxWidth: .infinity, maxHeight: 1)
                .foregroundColor(Color(.systemGray3))
        }
        .padding([.leading, .trailing, .top])
    }
    
//MARK: Edit profile
    private var editProfile: some View {
        VStack{
            Button(action: {
                
            }, label: {
                textView(text: "Edit Profile", size: 15)
                    .foregroundColor(Color("purple"))
                    .multilineTextAlignment(.leading)
                    .padding([.leading, .trailing, .top])
                
            })
            .frame(maxWidth: .infinity)
            
            Rectangle()
                .frame(maxWidth: .infinity, maxHeight: 1)
                .foregroundColor(Color(.systemGray3))
        }
        .padding([.leading,.trailing])
    }
    
//MARK: Background Mode Switch
    private var backgroundSwitch: some View {
        VStack{
            HStack{
                textView(text: "light/dark mode", size: 14)
                    .padding(.leading)
                Spacer()
                
                Toggle("", isOn: $isBackgroundModew)
                    .toggleStyle(SwitchToggleStyle(tint: Color("purple")))
                    .padding(.trailing)
            }
            
            Rectangle()
                .frame(maxWidth: .infinity, maxHeight: 1)
                .foregroundColor(Color(.systemGray3))
        }
        .padding([.leading,.trailing,.top])
    }
    
//MARK: Sign Out Btn
    private var signOut: some View {
      
            Button(action: {
                try? Authentication.signOut()
                print("sign out")
            }, label: {
                textView(text: "Sign Out", size: 15)
                    .foregroundColor(.red)
            })
            .padding([.top,.bottom])
    }
}

#Preview {
    ProfileView()
}
    
