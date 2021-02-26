import SwiftUI

struct SearchReposList: View {
    @ObservedObject var repoViewModel: RealRepoViewModel
    @EnvironmentObject var appState: AppState
    let name: String

    init(repoViewModel: RealRepoViewModel, name: String) {
        self.name = name
        self.repoViewModel = repoViewModel
    }

    func fetchReposByName() {
        repoViewModel.requestReposByName(name: name)
    }

    var body: some View {
        ScrollView {
            Text("\(name)").bold()
            Divider().padding(.vertical, 4)
            ForEach(repoViewModel.repos, id: \.id) { repo in
                NavigationLink(destination: RepoView(repo: repo)) {
                    VStack {
                        MiniRepoView(repo: repo)
                    }
                }
            }
            if repoViewModel.repos.count > 0 && repoViewModel.canFetchMore {
                BottomNavRow(buttonClick: fetchReposByName, loading: $repoViewModel.loading)
            }
            if let error = repoViewModel.error {
                Text(error).padding(.horizontal, 4)
            }
        }
        .navigationTitle(name)
        .padding(.horizontal, 2)
        .onAppear(perform: {
            fetchReposByName()
        })
    }
}

struct SearchReposList_Previews: PreviewProvider {
    static var previews: some View {
        SearchReposList(repoViewModel: RealRepoViewModel(appState: AppState()), name: "playify")
    }
}
