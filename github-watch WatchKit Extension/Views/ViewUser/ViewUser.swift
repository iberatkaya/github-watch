import SwiftUI

struct ViewUser: View {
    @EnvironmentObject var profileInteractor: RealProfileInteractor
    @EnvironmentObject var appState: AppState
    @State private var username: String = "metsey99"
    
    var body: some View {
        ScrollView {
            TextField("View User Profile", text: $username)
            NavigationLink(destination: UserProfile(username: username).environmentObject(appState).environmentObject(profileInteractor)){
                Text("Submit")
            }.disabled(username == "")
        }
    }
}

struct ViewUser_Previews: PreviewProvider {
    static var previews: some View {
        ViewUser()
    }
}
