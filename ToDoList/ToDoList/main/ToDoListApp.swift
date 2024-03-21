//
//  ToDoListApp.swift
//  ToDoList
//
//  Created by bakebrlk on 17.02.2024.
//

import SwiftUI
import FirebaseCore

@main
struct ToDoListApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            GeometryReader{ make in
                NavigationView{
                    CustomTabBar()
                }
                .onAppear{
                    if !sizeStatus() {
                        print("size")
                        setStatusSize(status: true)
                        setSize(width: make.size.width, height: make.size.height)
                    }else{
                        print("Size: \(getSize())")
                    }
                }
            }
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        
        return true
    }
}
