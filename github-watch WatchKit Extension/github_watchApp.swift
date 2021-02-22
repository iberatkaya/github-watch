import SwiftUI

@main
struct github_watchApp: App {
    @ObservedObject var appState = AppState()
     
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView(appState: appState).environmentObject(appState)
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
