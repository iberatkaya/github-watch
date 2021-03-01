import SwiftUI

struct CommitsList: View {
    let repoName: String
    let authorName: String
    @ObservedObject var commitViewModel: RealCommitsViewModel

    init(commitViewModel: RealCommitsViewModel, authorName: String, repoName: String) {
        self.commitViewModel = commitViewModel
        self.authorName = authorName
        self.repoName = repoName
    }

    func fetchCommits() {
        commitViewModel.requestCommitsByRepoName(username: authorName, repoName: repoName)
    }

    var body: some View {
        ScrollView {
            Text("\(repoName) Commits").bold()
            Divider().padding(.vertical, 4)
            ForEach(commitViewModel.commits, id: \.id) { commit in
                MiniCommitView(commit: commit)
                Divider().padding(.vertical, 4)
            }
            if commitViewModel.commits.count > 0 && commitViewModel.canFetchMore {
                BottomNavRow(buttonClick: fetchCommits, loading: commitViewModel.loading)
            }
            if let error = commitViewModel.error {
                Text(error).padding(.horizontal, 4)
            }
            if commitViewModel.loading {
                ProgressView()
            }
        }
        .navigationTitle(repoName)
        .padding(.horizontal, 2)
        .onAppear(perform: {
            fetchCommits()
        })
    }
}

struct CommitsList_Previews: PreviewProvider {
    static var previews: some View {
        CommitsList(commitViewModel: RealCommitsViewModel(appState: AppState()), authorName: "Selim", repoName: "Diyet-in")
    }
}
