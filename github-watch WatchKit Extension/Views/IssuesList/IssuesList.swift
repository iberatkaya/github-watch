import SwiftUI

struct IssuesList: View {
    let repoName: String
    let authorName: String
    @ObservedObject var issueViewModel: RealIssuesViewModel
    
    init(issueViewModel: RealIssuesViewModel, repoName: String, authorName: String) {
        self.issueViewModel = issueViewModel
        self.repoName = repoName
        self.authorName = authorName
    }
    
    func fetchIssues(){
        issueViewModel.requestIssuesByRepoName(username: authorName, repoName: repoName)
    }
    
    var body: some View {
        ScrollView {
            Text("\(repoName) Issues").bold()
            Divider().padding(.vertical, 4)
            ForEach(issueViewModel.issues, id: \.id) { issue in
                NavigationLink(destination: IssueView(issue: issue)) {
                    MiniIssueView(issue: issue)
                }
            }
            if issueViewModel.issues.count > 0 && issueViewModel.canFetchMore {
                BottomNavRow(buttonClick: fetchIssues, loading: issueViewModel.loading)
            }
            if let error = issueViewModel.error {
                Text(error).padding(.horizontal, 4)
            }
            if issueViewModel.loading {
                ProgressView()
            }
        }
        .navigationTitle(repoName)
        .padding(.horizontal, 2)
        .onAppear(perform: {
            fetchIssues()
        })
    }
}

struct IssuesList_Previews: PreviewProvider {
    static var previews: some View {
        IssuesList(issueViewModel: RealIssuesViewModel(appState: AppState()), repoName: "Test Repo", authorName: "iberatkaya")
    }
}
