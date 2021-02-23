import SwiftUI

@main
struct github_watchApp: App {
    @ObservedObject var appState: AppState
    @ObservedObject var profileInteractor: RealProfileInteractor
    @ObservedObject var connectivityController: ConnectivityController
    @ObservedObject var authInteractor: RealAuthInteractor
    @ObservedObject var repoInteractor: RealRepoInteractor
    
    init() {
        let myAppState = AppState()
        appState = myAppState
        profileInteractor = RealProfileInteractor(appState: myAppState)
        connectivityController = ConnectivityController(appState: myAppState)
        authInteractor = RealAuthInteractor(appState: myAppState)
        repoInteractor = RealRepoInteractor(appState: myAppState)
    }
     
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }.environmentObject(appState).environmentObject(profileInteractor).environmentObject(connectivityController).environmentObject(authInteractor).environmentObject(repoInteractor)
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
