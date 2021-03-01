import SwiftUI

struct UserRepos: View {
    @ObservedObject var repoViewModel: RealRepoViewModel
    let username: String

    init(repoViewModel: RealRepoViewModel, username: String) {
        self.username = username
        self.repoViewModel = repoViewModel
    }

    func fetchUserRepos() {
        repoViewModel.requestReposOfUser(username: username)
    }

    var body: some View {
        ScrollView {
            Text("\(username)").bold()
            Divider().padding(.vertical, 4)
            ForEach(repoViewModel.repos, id: \.id) { repo in
                NavigationLink(destination: RepoView(repo: repo)) {
                    MiniRepoView(repo: repo)
                }
            }
            if repoViewModel.repos.count > 0 && repoViewModel.canFetchMore {
                BottomNavRow(buttonClick: fetchUserRepos, loading: repoViewModel.loading)
            }
        }
        .navigationTitle(username)
        .padding(.horizontal, 2)
        .onAppear(perform: {
            fetchUserRepos()
        })
    }
}

struct UserRepos_Previews: PreviewProvider {
    static var previews: some View {
        UserRepos(repoViewModel: RealRepoViewModel(appState: AppState()), username: "iberatkaya")
    }
}
