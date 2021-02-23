import SwiftUI

struct SearchRepos: View {
    @State private var name: String = "Flutter"

    var body: some View {
        ScrollView {
            TextField("Search User Repo", text: $name)
            NavigationLink(destination: SearchReposList(name: name)) {
                Text("Submit")
            }.disabled(name == "")
        }.padding(.horizontal, 2)
    }
}

struct SearchRepos_Previews: PreviewProvider {
    static var previews: some View {
        SearchRepos()
    }
}
