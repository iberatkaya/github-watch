import SwiftUI
import SwiftyJSON

struct ContentView: View {
    @ObservedObject var authInteractor: RealAuthInteractor
    @ObservedObject var connectivityController: ConnectivityController
    @EnvironmentObject var appState: AppState
    
    init(appState: AppState) {
        authInteractor = RealAuthInteractor(appState: appState)
        connectivityController = ConnectivityController()
    }
    
    var body: some View {
        NavigationView {
            Home().environmentObject(authInteractor).environmentObject(connectivityController)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(appState: AppState())
    }
}
