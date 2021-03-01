import DateHelper
import SwiftUI

struct IssueView: View {
    let issue: Issue

    init(issue: Issue) {
        self.issue = issue
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
                    Divider().padding(.vertical, 4)
                }
                if let body = issue.body {
                    Text(body)
                        .foregroundColor(.gray)
                        .font(.system(size: 10))
                        .lineLimit(nil)
                        .fixedSize(horizontal: false, vertical: true)
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
                                    Text(creationDate.toString())
                                        .font(.system(size: 8))
                                        .foregroundColor(.gray)
                                }
                            }.padding(.leading, 4)
                            Spacer()
                        }.padding(EdgeInsets(top: 2, leading: 6, bottom: 2, trailing: 6))
                    }
                }
            }.padding(.vertical, 4)
                .padding(.horizontal, 8)
        }
        .navigationTitle(issue.issueNumber != nil ? "\(issue.issueNumber!)" : "")
    }
}

struct IssueView_Previews: PreviewProvider {
    static var previews: some View {
        IssueView(issue: Issue(title: "Can we play full duration song ?", body: "Is this possible? Thank you.", owner: ProfileUser(username: "user", name: nil, bio: nil, avatarUrl: "https://avatars.githubusercontent.com/u/34488374?v=4", email: nil, followers: nil, following: nil, company: nil, publicRepoCount: nil, privateRepoCount: nil, location: nil, userType: UserType.user), creationDate: Date(timeIntervalSince1970: TimeInterval(1614000000)), closedDate: nil, commentsCount: 4, issueNumber: 7))
    }
}
