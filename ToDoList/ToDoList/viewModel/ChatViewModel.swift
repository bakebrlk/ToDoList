//
//  ChatViewModel.swift
//  Chatgpt3.5
//
//  Created by Rauan on 29.11.2023.
//

import Foundation

extension ChatView {
    class ViewModel: ObservableObject {
        @Published var messages: [Message] = [Message(id: UUID().uuidString, role: .system, content: "You are Taskly Bot, an AI assistant for my to-do-list app. You are a chatbot that is designed to help users effortlessly organize their task and stay on top of their to-do list. Your ideal for individuals seeking to simplify their task management process. Whether they’re busy professionals, project managers, or small business owners, you can help users stay organized, prioritize tasks, and achieve their goals more effectively. Your role is to assist users in creating a to-do list based on the user’s task which they would like to accomplish, and tips on how they can accomplish a task. Provide feedback about the current plans, including any optimizations that you could make. Be friendly and helpful in your interactions. Feel free to ask customers about their preferences. Encourage users to reach out if they have any questions or need assistance.", createAt: Date())]
        
        @Published var currentInput: String = ""
        
        private let openAIService = OpenAIService()
        func sendMessage() {
            let newMessage = Message(id: UUID().uuidString, role: .user, content: currentInput, createAt: Date())
            messages.append(newMessage)
            currentInput = ""
            
//            Task {
//                let responce = await openAIService.sendMessage(messages: messages)
//                guard let receiveOpenAIMessage = responce?.choices.first?.message else {
//                    print("Had no message")
//                    return
//                }
//                let receivedMessage = Message(id: UUID(), role: receiveOpenAIMessage.role, content: receiveOpenAIMessage.content, createAt: Date())
//                await MainActor.run {
//                    messages.append(receivedMessage)
//                }
//            }
            openAIService.sendStreamMessage(messages: messages).responseStreamString { [weak self] stream in
                guard let self = self else { return }
                switch stream.event {
                case .stream(let responce):
                    switch responce {
                    case .success(let string):
                        let streamResponce = parseStreamData(string)
                        
                        streamResponce.forEach { newMessageResponce in
                            guard let messageContent = newMessageResponce.choices.first?.delta.content else {
                                return
                            }
                            guard let existingMessageIndex = self.messages.lastIndex(where: {$0.id == newMessageResponce.id}) else {
                                let newMessage = Message(id: newMessageResponce.id,role: .assistant,content: messageContent,createAt: Date())
                                self.messages.append(newMessage)
                                return
                            }
                            let newMessage = Message(id: newMessageResponce.id, role: .assistant, content: self.messages[existingMessageIndex].content + messageContent, createAt: Date())
                            self.messages[existingMessageIndex] = newMessage
                            
                        }
                        
                    case .failure(_):
                        print("something fails")
                    }
                case .complete(_):
                    print("Complete")
                }
            }
        }
        func parseStreamData(_ data: String) ->[ChatStreamCompletionResponse]{
            let responceString = data.split(separator: "data:").map({$0.trimmingCharacters(in: .whitespacesAndNewlines)}).filter({!$0.isEmpty})
            let jsonDecoder = JSONDecoder()
            
            return responceString.compactMap { jsonString in
                guard let jsonData = jsonString.data(using: .utf8), let streamResponce = try? jsonDecoder.decode(ChatStreamCompletionResponse.self, from: jsonData) else {
                    return nil
                }
                return streamResponce
            }
        }
        func cancelStream() {
            openAIService.cancelStream()
        }
    }
}

struct Message: Decodable {
    let id: String
    let role: SenderRole
    let content: String
    let createAt: Date
}

struct ChatStreamCompletionResponse: Decodable {
    let id: String
    let choices: [ChatStreamChoice]
}
struct ChatStreamChoice: Decodable {
    let delta: ChatStreamContent
}
struct ChatStreamContent: Decodable {
    let content: String?
}
