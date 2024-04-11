//
//  NavigationModifire.swift
//  ToDoList
//
//  Created by bakebrlk on 27.02.2024.
//

import SwiftUI

struct RouterView<Content: View>: View {
    @StateObject var router: Navigation = Navigation()

    private let content: Content
    
    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        NavigationStack(path: $router.path) {
            content
                .navigationDestination(for: Router.self) { route in
                    route.builder
                        .navigationBarBackButtonHidden(true)

            }
        }
        .accentColor(.black)
        .statusBar(hidden: false)
        .environmentObject(router)
    }
}
