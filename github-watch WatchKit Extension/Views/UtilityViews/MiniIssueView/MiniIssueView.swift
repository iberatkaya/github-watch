import DateHelper
import SwiftUI

struct MiniIssueView: View {
    let issue: Issue

    init(issue: Issue) {
        self.issue = issue
    }

    var body: some View {
        VStack {
            if let title = issue.title {
                Text(title)
                    .bold()
                    .font(.system(size: 10))
                    .lineLimit(6)
                Divider().padding(.vertical, 4)
            }
            if let body = issue.body {
                Text(body)
                    .foregroundColor(.gray)
                    .font(.system(size: 8))
                    .lineLimit(10)
            }
            VStack {
                if let author = issue.owner {
                    HStack {
                        VStack {
                            if let creationDate = issue.creationDate {
                                HStack {
                                    if let username = author.username {
                                        Text("@" + username)
                                            .font(.system(size: 8))
                                            .foregroundColor(.gray)
                                    }
                                    Spacer()
                                    VStack {
                                        Text("Opened:")
                                            .font(.system(size: 8))
                                            .foregroundColor(.gray)
                                        Text(creationDate.toStringWithRelativeTime())
                                            .font(.system(size: 8))
                                            .foregroundColor(.white)
                                    }
                                }
                            }
                            if let closedDate = issue.closedDate {
                                HStack {
                                    if issue.closedDate != nil {
                                        Image(systemName: "checkmark.circle.fill")
                                            .resizable()
                                            .frame(width: 10, height: 10)
                                            .foregroundColor(.red)
                                    }
                                    Spacer()
                                    VStack {
                                        Text("Closed:")
                                            .font(.system(size: 8))
                                            .foregroundColor(.red)
                                        Text(closedDate.toStringWithRelativeTime())
                                            .font(.system(size: 8))
                                            .foregroundColor(.white)
                                    }
                                }
                            }
                        }
                    }.padding(EdgeInsets(top: 2, leading: 6, bottom: 2, trailing: 6))
                }
            }
        }
    }
}

struct MiniIssueView_Previews: PreviewProvider {
    static var previews: some View {
        MiniIssueView(issue: Issue(title: "Can we play full duration song ?", body: "Is this possible? Thank you.", owner: ProfileUser(username: "user", name: nil, bio: nil, avatarUrl: "https://avatars.githubusercontent.com/u/34488374?v=4", email: nil, followers: nil, following: nil, company: nil, publicRepoCount: nil, privateRepoCount: nil, location: nil, userType: UserType.user), creationDate: Date(timeIntervalSince1970: TimeInterval(1614000000)), closedDate: Date(timeIntervalSince1970: TimeInterval(1614400000)), commentsCount: 4, issueNumber: 7))
    }
}
