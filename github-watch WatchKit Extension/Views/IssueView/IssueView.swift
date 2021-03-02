import DateHelper
import SwiftUI

struct IssueView: View {
    let username: String
    let repoName: String
    let issue: Issue
    @ObservedObject var commentsViewModel: RealCommentsViewModel

    init(commentsViewModel: RealCommentsViewModel, username: String, repoName: String, issue: Issue) {
        self.issue = issue
        self.username = username
        self.repoName = repoName
        self.commentsViewModel = commentsViewModel
    }

    func fetchComments() {
        if let issueID = issue.issueNumber {
            commentsViewModel.requestCommentsOfIssue(username: username, repoName: repoName, issueID: "\(issueID)")
        }
    }

    var body: some View {
        ScrollView {
            VStack {
                if let title = issue.title {
                    Text(title)
                        .bold()
                        .font(.system(size: 12))
                        .lineLimit(nil)
                        .fixedSize(horizontal: false, vertical: true)
                        .padding(.bottom, 6)
                }
                if let body = issue.body {
                    HStack {
                        Text(body)
                            .foregroundColor(.gray)
                            .font(.system(size: 10))
                            .lineLimit(nil)
                            .fixedSize(horizontal: false, vertical: true)
                        Spacer()
                    }
                }
                VStack {
                    if let author = issue.owner {
                        HStack {
                            if let avatar = author.avatarUrl {
                                UserImage(url: avatar, width: 32, height: 32).padding(.trailing, 4)
                            }
                            VStack {
                                if let username = author.username {
                                    Text("@" + username)
                                        .font(.system(size: 10))
                                        .foregroundColor(.gray)
                                }
                                if let creationDate = issue.creationDate {
                                    Text(creationDate.toStringWithRelativeTime())
                                        .font(.system(size: 8))
                                        .foregroundColor(.gray)
                                }
                            }.padding(.leading, 4)
                            Spacer()
                        }.padding(EdgeInsets(top: 2, leading: 6, bottom: 2, trailing: 6))
                    }
                }

                Divider().padding(.vertical, 4)

                ForEach(commentsViewModel.comments, id: \.id) { comment in
                    CommentView(comment: comment)
                    Divider().padding(.vertical, 6)
                }
                if commentsViewModel.comments.count > 0 && commentsViewModel.canFetchMore {
                    BottomNavRow(buttonClick: fetchComments, loading: commentsViewModel.loading)
                }
                if let error = commentsViewModel.error {
                    Text(error).padding(.horizontal, 4)
                }
                if commentsViewModel.loading {
                    ProgressView()
                }
            }.padding(.vertical, 4)
                .padding(.horizontal, 8)
        }
        .onAppear(perform: {
            fetchComments()
        })
        .navigationTitle(issue.issueNumber != nil ? "\(issue.issueNumber!)" : "")
    }
}

struct IssueView_Previews: PreviewProvider {
    static var issue = Issue(title: "Can we play full duration song ?", body: "Is this possible? Thank you.", owner: ProfileUser(username: "user", name: nil, bio: nil, avatarUrl: "https://avatars.githubusercontent.com/u/34488374?v=4", email: nil, followers: nil, following: nil, company: nil, publicRepoCount: nil, privateRepoCount: nil, location: nil, userType: UserType.user), creationDate: Date(timeIntervalSince1970: TimeInterval(1614000000)), closedDate: nil, commentsCount: 4, issueNumber: 7)
    static var previews: some View {
        IssueView(commentsViewModel: RealCommentsViewModel(appState: AppState(), issue: issue), username: "iberatkaya", repoName: "playify", issue: issue)
    }
}
