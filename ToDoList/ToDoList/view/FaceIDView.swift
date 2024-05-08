//
//  FaceIDView.swift
//  Taskly
//
//  Created by bakebrlk on 15.04.2024.
//

import SwiftUI
import LocalAuthentication

struct FaceIDView: View {
    
    @EnvironmentObject var navigate: Navigation
    private var context = LAContext()
    
    @State public var checking: Bool = false
    @State public var isChecked: Bool = false
    @State public var showAlert: Bool = false
    
    var body: some View {
        VStack{
            
            textView(text: "Biometric Security", size: 24)
                .foregroundStyle(LinearGradient(colors: [.white, .orange, .mint], startPoint: .topLeading, endPoint: .bottomTrailing))
                .padding()
            Spacer()
            
            faceId
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(LinearGradient(colors: [Color("purple"), .blue, .black], startPoint: .topLeading, endPoint: .bottomTrailing))
        .alert(isPresented: $showAlert, content: {
            Alert(title: Text("Error"), message: Text("Error trying to login with credentials, please try again"), dismissButton: .default(Text("Ok")))
        })
        
        .onAppear{
            Task{
                await auth()
            }
        }
    }
    
    private var faceId: some View  {
        Button(action: {
            Task{
                await auth()
            }
        }, label: {
            ZStack{
               
                if !checking{
                    image(sysName: "faceid")
                        .foregroundStyle(LinearGradient(colors: [Color("purple"), .blue, .black], startPoint: .topLeading, endPoint: .bottomTrailing))
                }else if isChecked {
                    image(sysName: "checkmark.circle")
                        .foregroundColor(.green)
                }else if !isChecked && checking{
                    image(sysName: "xmark.circle")
                        .foregroundColor(.red)
                }
                
            }
            .frame(maxWidth: Size.size[0]/3, maxHeight: Size.size[0]/3)
            .background(Color(.systemGray2).opacity(0.6))
            .cornerRadius(16)
        })
        
    }
    
    private func image(sysName: String) -> some View {
        Image(systemName: sysName)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .padding(30)

    }
    
    private func auth() async{
       
        let reason = "Log into your account"
        var error: NSError?
        
        guard context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) else {
            return
        }
        
        do {
            let success = try await context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason)
            
            checking = true
            if success {
                DispatchQueue.main.async {
                    self.isChecked = true
                    DispatchQueue.main.asyncAfter(deadline: .now()+1) {
                        navigate.navigateTo(.splashScreen)
                    }
                }
            } else {
                self.isChecked = false
                print("Authentication failed")
            }
        } catch {
            self.isChecked = false
        }
    
    }
}

#Preview {
    FaceIDView()
}
