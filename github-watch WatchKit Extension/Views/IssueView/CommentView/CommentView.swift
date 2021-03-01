//
//  CommentView.swift
//  github-watch WatchKit Extension
//
//  Created by Ibrahim Berat Kaya on 2.03.2021.
//

import SwiftUI

struct CommentView: View {
    let comment: Comment

    var body: some View {
        VStack {
            if let body = comment.body {
                HStack {
                    Text(body)
                        .foregroundColor(.gray)
                        .font(.system(size: 10))
                        .lineLimit(nil)
                        .fixedSize(horizontal: false, vertical: true)
                    Spacer()
                }.padding(.bottom, 4)
            }
            VStack {
                if let author = comment.owner {
                    HStack {
                        if let avatar = author.avatarUrl {
                            UserImage(url: avatar, width: 32, height: 32).padding(.trailing, 4)
                        }
                        VStack {
                            if let username = comment.owner?.username {
                                Text("@" + username)
                                    .font(.system(size: 10))
                                    .foregroundColor(.gray)
                            }
                            if let creationDate = comment.creationDate {
                                Text(creationDate.toStringWithRelativeTime())
                                    .font(.system(size: 8))
                                    .foregroundColor(.gray)
                            }
                        }.padding(.leading, 4)
                        Spacer()
                    }.padding(EdgeInsets(top: 2, leading: 6, bottom: 2, trailing: 6))
                }
            }
        }
    }
}

struct CommentView_Previews: PreviewProvider {
    static var previews: some View {
        CommentView(comment: Comment(body: "This is a test comment", owner: ProfileUser(username: "iberatkaya", name: "Ibrahim Berat Kaya", bio: "I\'m interested in Flutter, Node.js, React Native, React.js, Swift & SwiftUI, Express.js, and Rust.", avatarUrl: "https://avatars.githubusercontent.com/u/34488374?v=4", email: "beratkaya1998@gmail.com", followers: 23, following: 21, company: "ITU", publicRepoCount: 38, privateRepoCount: 24, location: "Istanbul", userType: UserType.user), creationDate: Date(timeIntervalSince1970: TimeInterval(50000))))
    }
}
