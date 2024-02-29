//
//  HomePageView.swift
//  ToDoList
//
//  Created by bakebrlk on 01.03.2024.
//

import SwiftUI

struct HomePageView: View {
    
    @State private var isImagePickerPresented = false
    @State private var selectedImage: UIImage?
    
    var body: some View {
        
        NavigationView{
            GeometryReader { make in
                VStack(alignment: .leading){
                    topBar(height: make.size.height)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
        
    }
}

extension HomePageView{
    
    // MARK: - TOP BAR
    private func topBar(height: CGFloat) -> some View{
        HStack{
            avatar(height: height/10)
            userName
            Spacer()
            
            notification
                .frame(maxHeight: height/13)
        }
        .frame(maxWidth: .infinity, maxHeight: height/10)
    }
    
    private var userName: some View{
        VStack(alignment: .leading){
            textView(text: "Hello!", size: 18)
            textView(text: "Bekzat", size: 22)
        }
    }
    
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
        .padding(.leading)
        .cornerRadius(.infinity)
        
    }
    
    private var notification: some View {
        CustomImage.getImage(systemName: "bell.fill")
            .padding()
    }
    
    //MARK: All Statistics
    
    private func allStatistics(height: CGFloat) -> some View{
        HStack {
            Text(" ")
        }
        .frame(maxWidth: .infinity, maxHeight: height)
        .cornerRadius(20)
    }
    
}

#Preview {
    HomePageView()
}
