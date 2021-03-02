import SwiftUI

struct UserIssues: View {
    @ObservedObject var issueViewModel: RealIssuesViewModel
    @EnvironmentObject var appState:  AppState
    
    init(issueViewModel: RealIssuesViewModel) {
        self.issueViewModel = issueViewModel
    }
    
    func fetchIssues(){
        issueViewModel.requestUserIssues()
    }
    
    var body: some View {
        ScrollView {
            Text("Assigned Issues").bold()
            Divider().padding(.vertical, 4)
            ForEach(issueViewModel.issues, id: \.id) { issue in
                NavigationLink(destination: IssueView(commentsViewModel: RealCommentsViewModel(appState: appState, issue: issue), username: issue.owner?.username ?? "", repoName: issue.repoName ?? "",  issue: issue)) {
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
        .navigationTitle("Issues")
        .padding(.horizontal, 2)
        .onAppear(perform: {
            fetchIssues()
        })
    }
}

struct UserIssues_Previews: PreviewProvider {
    static var previews: some View {
        UserIssues(issueViewModel: RealIssuesViewModel(appState: AppState()))
    }
}
