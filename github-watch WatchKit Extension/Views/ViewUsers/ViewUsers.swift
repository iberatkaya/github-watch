import SwiftUI

struct ViewUsers: View {
    @EnvironmentObject var profileInteractor: RealProfileInteractor
    @EnvironmentObject var appState: AppState
    @State private var username: String = ""
    
    var body: some View {
        ScrollView {
            TextField("View User Profile", text: $username)
            NavigationLink(destination: UserProfile(username: username).environmentObject(appState).environmentObject(profileInteractor)){
                Text("Submit")
            }.disabled(username == "")
        }
    }
}

struct ViewUsers_Previews: PreviewProvider {
    static var previews: some View {
        ViewUsers()
    }
}
