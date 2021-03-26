import SwiftUI

@main
struct github_watchApp: App {
    @ObservedObject var appState: AppState
    @ObservedObject var connectivityController: ConnectivityController

    init() {
        if CommandLine.arguments.contains("-reset-user") {
            UserDefaults.standard.removeObject(forKey: "user")
        }
        let myAppState = AppState()
        appState = myAppState
        connectivityController = ConnectivityController(appState: myAppState)
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(appState).environmentObject(connectivityController)
        }
    }
}
