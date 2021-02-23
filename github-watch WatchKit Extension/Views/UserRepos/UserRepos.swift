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

    init(username: String) {
        self.username = username
    }

    var body: some View {
        ScrollView {
            Text("\(username)")
            Button("readme test", action: {
                let url = URL(string: "https://raw.githubusercontent.com/iberatkaya/adearnings/main/README.md")
                FileDownloader.loadFileAsync(url: url!) { (path, error) in
                    print("error: \(error)")
                    print("PDF File downloaded to : \(path!)")
                    do {
                    let text = try String(contentsOf: URL(string: "file://\(path!)")!, encoding: .utf8)
                    print(text)
                    } catch {
                        print(error.localizedDescription)
                    }
                    

                }
            })
        }.onAppear(perform: {
            repoInteractor.requestReposOfUser(username: username, completed: {_ in})
        })
    }
}

struct UserRepos_Previews: PreviewProvider {
    static var previews: some View {
        UserRepos(username: "iberatkaya")
    }
}
