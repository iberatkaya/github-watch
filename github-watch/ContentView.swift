import SwiftUI
import SwiftyJSON

struct ContentView: View {
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        NavigationView {
            Home(authViewModel: RealAuthViewModel(appState: appState))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
