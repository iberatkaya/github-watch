//
//  UserRepos.swift
//  github-watch WatchKit Extension
//
//  Created by Ibrahim Berat Kaya on 23.02.2021.
//

import SwiftUI

struct UserRepos: View {
    @EnvironmentObject var repoInteractor: RealRepoInteractor
    let username: String
    @State var repos: [Repo] = []

    init(username: String) {
        self.username = username
    }

    var body: some View {
        ScrollView {
            Text("\(username)").bold()
            Divider().padding(.vertical, 4)
            ForEach(repos, id: \.id) { repo in
                NavigationLink(destination: RepoView(repo: repo)) {
                    Text(repo.name)
                }
            }
        }.onAppear(perform: {
            repoInteractor.requestReposOfUser(username: username, completed: { myRepos in
                if let myRepos = myRepos {
                    DispatchQueue.main.async {
                        repos = myRepos
                        print(myRepos)
                    }
                }
            })
        })
    }
}

struct UserRepos_Previews: PreviewProvider {
    static var previews: some View {
        UserRepos(username: "iberatkaya")
    }
}
