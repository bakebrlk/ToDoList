//
//  ChatView.swift
//  Taskly
//
//  Created by bakebrlk on 01.04.2024.
//

import SwiftUI

struct ChatView: View {
    @ObservedObject var viewModel = ViewModel()
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var navigate: Navigation
    
    var body: some View {
        VStack {
            HStack {
                
                Button {
                    navigate.navigateBack()
                } label: {
                    Image(systemName: "arrowshape.turn.up.backward.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
                .frame(width: 25, height: 25)

                Text("AI Helper")
                    .font(.title)
                    .fontWeight(.bold)
                Spacer()
            }
            ScrollView {
                ForEach(viewModel.messages.filter({$0.role != .system}), id: \.id) { message in
                    messageView(message: message)
                }
            }
            HStack {
                TextField("Enter a message...", text: $viewModel.currentInput)
                    .padding()
                    .background(colorScheme == .dark ? .gray.opacity(0.2) : .gray.opacity(0.4))
                    .foregroundColor(BackgroundMode().textColor())
                    .autocorrectionDisabled()
                    .cornerRadius(12)
                Button {
                    viewModel.cancelStream()
                } label: {
                    Image(systemName: "stop.circle.fill")
                        .foregroundColor(.blue)
                        .padding(.horizontal, 5)
                        .font(.largeTitle)
                        .fontWeight(.semibold)
                }
                Button {
                    viewModel.sendMessage()
                } label: {
                    Image(systemName: "arrow.right.circle.fill")
                        .foregroundColor(.blue)
                        .padding(.horizontal, 5)
                        .font(.largeTitle)
                        .fontWeight(.semibold)
                }
            }
        }
        .padding()
        .background(BackgroundMode().viewBack())
//        .ignoresSafeArea(.all)
    }
    
    func messageView(message: Message) -> some View{
        HStack {
            if message.role == .user { Spacer()}
            Text(message.content)
                .foregroundColor(message.role == .user ? .white : nil)
                .padding()
                .background(message.role == .user ? Color.blue : Color.gray.opacity(0.4))
                .cornerRadius(24)
            if message.role == .assistant { Spacer()}
        }
    }
}

#Preview {
    ChatView()
}
