import SwiftUI

struct ViewUser: View {
    @State private var username: String = ""
    @EnvironmentObject var appState: AppState

    var body: some View {
        ScrollView {
            TextField("View User Profile", text: $username)
            NavigationLink(destination: UserProfile(profileViewModel: RealProfileViewModel(appState: appState), username: username)) {
                Text("Submit")
            }.disabled(username == "")
        }.padding(.horizontal, 2)
    }
}

struct ViewUser_Previews: PreviewProvider {
    static var previews: some View {
        ViewUser()
    }
}
