import SwiftUI

struct SearchRepos: View {
    @State private var name: String = ""
    @EnvironmentObject var appState: AppState

    var body: some View {
        ScrollView {
            TextField("Search User Repo", text: $name)
            NavigationLink(destination: SearchReposList(repoViewModel: RealRepoViewModel(appState: appState), name: name)) {
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
