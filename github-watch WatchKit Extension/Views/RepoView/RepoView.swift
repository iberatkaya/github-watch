//
//  RepoView.swift
//  github-watch WatchKit Extension
//
//  Created by Ibrahim Berat Kaya on 23.02.2021.
//

import SwiftUI

struct RepoView: View {
    let repo: Repo 
    
    var body: some View { 
        ScrollView {
            Text(repo.name)
                .bold()
                .font(.system(size: 20))
                .padding(.bottom, 4)
            if let description = repo.description {
                HStack {
                    Text(description)
                        .foregroundColor(.gray)
                        .font(.system(size: 14))
                    Spacer()
                }.padding(.bottom, 2)
            }
            
            Divider().padding(.vertical, 6)
            
            VStack {
                Text("Info")
                    .bold()
                    .font(.system(size: 16))
                    .padding(.bottom, 4)
                
                HStack {
                    Text("Owner:")
                        .foregroundColor(.gray)
                        .font(.system(size: 12))
                    Text("@\(repo.ownerName)")
                        .bold()
                        .font(.system(size: 12))
                    Spacer()
                }
                
                if let language = repo.language {
                    HStack {
                        Text("Language:")
                            .foregroundColor(.gray)
                            .font(.system(size: 12))
                        Text(language)
                            .bold()
                            .font(.system(size: 12))
                        Spacer()
                    }
                }
                
                if let licenseName = repo.licenseName {
                    HStack {
                        Text("License:")
                            .foregroundColor(.gray)
                            .font(.system(size: 12))
                        Text(licenseName)
                            .bold()
                            .font(.system(size: 12))
                        Spacer()
                    }
                }
                
                HStack {
                    Text("Stars:")
                        .foregroundColor(.gray)
                        .font(.system(size: 12))
                    Text("\(repo.starCount)")
                        .bold()
                        .font(.system(size: 12))
                    Spacer()
                }
                
                HStack {
                    Text("Forks:")
                        .foregroundColor(.gray)
                        .font(.system(size: 12))
                    Text("\(repo.forks)")
                        .bold()
                        .font(.system(size: 12))
                    Spacer()
                }
                
                HStack {
                    Text("Issues:")
                        .foregroundColor(.gray)
                        .font(.system(size: 12))
                    Text("\(repo.issueCount)")
                        .bold()
                        .font(.system(size: 12))
                    Spacer()
                }
                
                HStack {
                    Text("Watchers:")
                        .foregroundColor(.gray)
                        .font(.system(size: 12))
                    Text("\(repo.watcherCount)")
                        .bold()
                        .font(.system(size: 12))
                    Spacer()
                }
            }
            
            Divider().padding(.vertical, 6)
            
            NavigationLink(
                destination: Markdown(username: repo.ownerName, repoName: repo.name)){
                Text("View Readme")
            }
        }.padding(.horizontal, 4)
    }
}

struct RepoView_Previews: PreviewProvider {
    static var previews: some View {
        RepoView(repo: Repo(name: "playify", ownerName: "iberatkaya", issueCount: 0, forks: 2, starCount: 17, watcherCount: 17, description: "This is a test repo description.", language: "Dart", licenseName: "MIT License"))
    }
}
