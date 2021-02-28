import SwiftUI

@main
struct github_watchApp: App {
    @ObservedObject var appState: AppState
    @ObservedObject var connectivityController: ConnectivityController

    init() {
        let myAppState = AppState()
        appState = myAppState
        connectivityController = ConnectivityController(appState: myAppState)
    }

    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
            .environmentObject(appState)
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
