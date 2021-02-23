import SwiftUI

struct ViewUsers: View {
    @EnvironmentObject var profileInteractor: RealProfileInteractor
    @EnvironmentObject var appState: AppState
    @State private var username: String = "iberatkaya"
    
    var body: some View {
        ScrollView {
            TextField("View User Profile", text: $username)
            NavigationLink(destination: UserProfile(username: username)){
                Text("Submit")
            }.disabled(username == "")
        }
    }
}

struct ViewUsers_Previews: PreviewProvider {
    static var previews: some View {
        ViewUsers().environmentObject(RealProfileInteractor(appState: AppState())).environmentObject(AppState())
    }
}
