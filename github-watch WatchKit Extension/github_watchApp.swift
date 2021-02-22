//
//  github_watchApp.swift
//  github-watch WatchKit Extension
//
//  Created by Ibrahim Berat Kaya on 22.02.2021.
//

import SwiftUI

@main
struct github_watchApp: App {
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
