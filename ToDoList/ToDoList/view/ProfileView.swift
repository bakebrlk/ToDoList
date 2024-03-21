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
    
    @ObservedObject private var backMode: BackgroundMode
    
    @EnvironmentObject var navigate: Navigation

    init(backMode: BackgroundMode){
        self.backMode = backMode
    }
    
//MARK: Body
    var body: some View {
        VStack{
            navBar
            Spacer()
            avatar(height: Size.size[1]/3)

            settings
            
            textView(text: "Taskly!", size: 32)
                .foregroundColor(Color("purple"))
                .padding([.top], 15)
                .padding(.bottom,30)
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .environment(\.colorScheme, BackgroundMode().isDark ? .dark : .light)
        .background(BackgroundMode().viewBack())
        .task {
            try? await user.userInfo()
        }
    }
}

extension ProfileView{
//MARK: Nav Bar
    private var navBar: some View {
        NavigationTopBar(title: "Profile")
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
        
        ScrollView{
            VStack{
                userInfo(title: "nick name: ", description: user.user?.name ?? "user")
                userInfo(title: "email: ", description: user.user?.email ?? "user@gmail.com")
                backgroundSwitch
                editProfile
                signOut
            }
            .frame(maxWidth: Size.size[0]/1.2, maxHeight: Size.size[1]/2.6)
            .background(BackgroundMode().isDark ? Color(.systemGray) : Color.white)
            .cornerRadius(20)
            .padding([.leading, .trailing],40)
        }
    }
        
    
//MARK: User Info
    private func userInfo(title: String, description: String) -> some View {
        VStack{
            HStack{
                textView(text: title, size: 14)
                    .foregroundColor(BackgroundMode().textColor())
                    .padding(.leading)
                Spacer()
                
                textView(text: description, size: 14)
                    .foregroundColor(BackgroundMode().textColor())
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
                navigate.navigateTo(.checkAccount)
            }, label: {
                textView(text: "Edit Profile", size: 15)
                    .foregroundColor(.cyan)
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
                    .foregroundColor(BackgroundMode().textColor())
                    .padding(.leading)
                Spacer()
                
                Toggle("", isOn: backMode.$isDark)
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
    
    ProfileView(backMode: BackgroundMode())
}
    
