import SwiftUI
import SwiftyJSON

struct ContentView: View {
    @ObservedObject var authViewModel: RealAuthViewModel
    @ObservedObject var connectivityController: ConnectivityController
    @EnvironmentObject var appState: AppState
    
    init(appState: AppState) {
        authViewModel = RealAuthViewModel(appState: appState)
        connectivityController = ConnectivityController()
    }
    
    var body: some View {
        NavigationView {
            Home(authViewModel: RealAuthViewModel(appState: appState))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(appState: AppState())
    }
}
