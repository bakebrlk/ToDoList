//
//  ProfileView.swift
//  ToDoList
//
//  Created by bakebrlk on 17.03.2024.
//

import SwiftUI

struct ProfileView: View {
           
    @StateObject public var user: UserResponse
    
    @ObservedObject public var backMode: BackgroundMode
    @EnvironmentObject var navigate: Navigation

    @State private var editProfileCheck = false
    @State private var avatarData: Foundation.Data? = nil
    
    
//MARK: Body
    var body: some View {
        VStack{
            navBar
            Spacer()
            avatar(height: Size.size[1]/3)

            settings
            
            textView(text: "Taskly!", size: 32)
                .foregroundColor(BackgroundMode().isDark ? .yellow : Color("purple"))
                .padding([.top], 15)
                .padding(.bottom,30)
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .environment(\.colorScheme, BackgroundMode().isDark ? .dark : .light)
        .background(BackgroundMode().viewBack())
        .task {
            
            do {
                try? await user.userInfo()
                
                if let user = user.user {
                    avatarData = try? await FirebaseFunction.getDataImage(userId: user.id, path: user.avatarURL)
                    print(user.avatarURL)
                }
            }
        }
        
        .sheet(isPresented: $editProfileCheck, content: {
            EditProfileView(checkPresent: $editProfileCheck, user: user, avatarData: $avatarData)
                .presentationDetents([.medium])
        })
    }
}

extension ProfileView{
//MARK: Nav Bar
    private var navBar: some View {
        NavigationBar().NavigationTopBar(title: "Profile", navigateTo: navigateChat)
    }
    private func navigateChat(){
        navigate.navigateTo(.chat)
    }
    
//MARK: Avatar
    private func avatar(height: CGFloat) -> some View {
        Group{
           
            CustomImage.getImage(uiImage: (UIImage(data: avatarData ?? Foundation.Data()) ?? UIImage(systemName: "person.circle"))!, height: Size.size[1]/4)
            
        }
        .frame(maxWidth: height, maxHeight: height)
        .cornerRadius(height/4)
        
        
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
//            .frame(maxWidth: Size.size[0]/1.2, maxHeight: Size.size[1]/2.6)
//            .background(BackgroundMode().isDark ? Color(.systemGray) : Color.white)
//            .cornerRadius(20)
//            .padding([.leading, .trailing],40)
            .padding()
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
//                navigate.navigateTo(.checkAccount)
                editProfileCheck.toggle()
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
                    .toggleStyle(SwitchToggleStyle(tint: BackgroundMode().avtorColor()))
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
                navigate.navigateTo(.checkAccount)
                print("sign out")
            }, label: {
                textView(text: "Sign Out", size: 15)
                    .foregroundColor(.red)
            })
            .padding([.top,.bottom])
    }
}

#Preview {
    
    ProfileView(user:UserResponse(), backMode: BackgroundMode())
}
    
