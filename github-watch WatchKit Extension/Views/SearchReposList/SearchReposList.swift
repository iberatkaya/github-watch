import SwiftUI

struct SearchReposList: View {
    @EnvironmentObject var repoInteractor: RealRepoInteractor
    let name: String
    @State var loading = false
    @State var repos: [Repo] = []
    @State var canFetchMore = true
    @State var error: String?

    init(name: String) {
        self.name = name
    }

    func fetchReposByName() {
        loading = true
        repoInteractor.requestReposByName(name: name, completed: { myRepos in
            DispatchQueue.main.async {
                repos += myRepos
                if myRepos.isEmpty {
                    canFetchMore = false
                }
                error = nil
                loading = false
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
            if let error = error {
                Text(error).padding(.horizontal, 4)
            }
        }
        .navigationTitle(name)
        .padding(.horizontal, 2)
        .onAppear(perform: {
            repoInteractor.resetRequestReposByNamePage()
            fetchReposByName()
        })
    }
}

struct SearchReposList_Previews: PreviewProvider {
    static var previews: some View {
        SearchReposList(name: "playify")
    }
}
