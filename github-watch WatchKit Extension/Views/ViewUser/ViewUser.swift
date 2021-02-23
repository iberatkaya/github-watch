import SwiftUI

struct ViewUser: View {
    @State private var username: String = "kaplanbar"

    var body: some View {
        ScrollView {
            TextField("View User Profile", text: $username)
            NavigationLink(destination: UserProfile(username: username)) {
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
