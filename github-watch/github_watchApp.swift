import SwiftUI

@main
struct github_watchApp: App {
    @ObservedObject var appState = AppState()
    
    var body: some Scene {
        WindowGroup {
            ContentView(appState: appState).environmentObject(appState)
        }
    }
}
