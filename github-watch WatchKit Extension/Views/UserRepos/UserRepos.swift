import SwiftUI

struct UserRepos: View {
    @EnvironmentObject var repoInteractor: RealRepoInteractor
    let username: String
    @State var loading = false
    @State var repos: [Repo] = []
    @State var canFetchMore = true
    @State var error: String?

    init(username: String) {
        self.username = username
    }

    func fetchUserRepos() {
        loading = true
        repoInteractor.requestReposOfUser(username: username, completed: { myRepos in
            DispatchQueue.main.async {
                repos += myRepos
                if myRepos.isEmpty {
                    canFetchMore = false
                }
                loading = false
                error = nil
            }

        }, onError: { err in
            DispatchQueue.main.async {
                loading = false
                error = err
            }
        })
    }

    var body: some View {
        ScrollView {
            Text("\(username)").bold()
            Divider().padding(.vertical, 4)
            ForEach(repos, id: \.id) { repo in
                NavigationLink(destination: RepoView(repo: repo)) {
                    MiniRepoView(repo: repo)
                }
            }
            if repos.count > 0 && canFetchMore {
                BottomNavRow(buttonClick: fetchUserRepos, loading: $loading)
            }
        }
        .navigationTitle(username)
        .padding(.horizontal, 2)
        .onAppear(perform: {
            repoInteractor.resetRequestReposOfUserPage()
            fetchUserRepos()
        })
    }
}

struct UserRepos_Previews: PreviewProvider {
    static var previews: some View {
        UserRepos(username: "iberatkaya")
    }
}
