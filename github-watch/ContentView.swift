import SwiftUI
import SwiftyJSON

struct ContentView: View {
    @ObservedObject var connectivityController: ConnectivityController
    @EnvironmentObject var appState: AppState
    
    init(appState: AppState) {
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
