//
//  ToDoListApp.swift
//  ToDoList
//
//  Created by bakebrlk on 17.02.2024.
//
import SwiftUI
import FirebaseCore
import Firebase
//import FirebaseMessaging
//import UserNotifications

@main
struct ToDoListApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    private var backMode = BackgroundMode()
    
    var body: some Scene {
        WindowGroup {
            GeometryReader{ make in
                RouterView{
                    
                    if !statusWelcomePage() {
                        WelcomePageView()
                    }
                    else if Authentication.checkAuthentication() {
                        CheckAccountView()
                    } else {
                        if getFaceID() {
                            FaceIDView()
                        }else{
                            SplashScreen()
                        }
                    }
                }
                .onAppear{
                    if !sizeStatus() {
                        setStatusSize(status: true)
                        setSize(width: make.size.width, height: make.size.height)
                    } else {
                        print("Size: \(getSize())")
                        print("status: \(statusWelcomePage())")
                    }
                }
            }
        }
    }
}

class AppDelegate: UIResponder, UIApplicationDelegate, MessagingDelegate, UNUserNotificationCenterDelegate{
    
    var window: UIWindow?
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        FirebaseApp.configure()
//        
//        Messaging.messaging().delegate = self
//        UNUserNotificationCenter.current().delegate = self
//        
//        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { success, _ in
//            guard success else {
//                return
//            }
//            print("Success in APNS registry")
//        }
//        
//        Messaging.messaging().isAutoInitEnabled = true
//        application.registerForRemoteNotifications()
        return true
    }
    
//    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
//        if let token = fcmToken {
//            print("FCM registration token: \(token)")
//        }
//        print("message")
//    }
}
