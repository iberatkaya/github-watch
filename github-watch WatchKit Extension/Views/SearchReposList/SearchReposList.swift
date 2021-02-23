import SwiftUI

struct SearchReposList: View {
    @EnvironmentObject var repoInteractor: RealRepoInteractor
    let name: String
    @State var loading = false
    @State var repos: [Repo] = []
    @State var canFetchMore = true

    init(name: String) {
        self.name = name
    }

    func fetchReposByName() {
        loading = true
        repoInteractor.requestReposByName(name: name, completed: { myRepos in
            if let myRepos = myRepos {
                DispatchQueue.main.async {
                    repos += myRepos
                    if myRepos.isEmpty {
                        canFetchMore = false
                    }
                    loading = false
                }
            } else {
                DispatchQueue.main.async {
                    loading = false
                }
            }
        })
    }

    var body: some View {
        ScrollView {
            Text("\(name)").bold()
            Divider().padding(.vertical, 4)
            ForEach(repos, id: \.id) { repo in
                NavigationLink(destination: RepoView(repo: repo)) {
                    VStack {
                        MiniRepoView(repo: repo)
                    }
                }
            }
            if repos.count > 0 && canFetchMore {
                BottomNavRow(buttonClick: fetchReposByName, loading: $loading)
            }
        }
        .padding(.horizontal, 2)
        .onAppear(perform: {
            repoInteractor.resetPage()
            fetchReposByName()
        })
    }
}

struct SearchReposList_Previews: PreviewProvider {
    static var previews: some View {
        SearchReposList(name: "playify")
    }
}
