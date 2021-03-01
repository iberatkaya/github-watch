import SwiftUI

struct RepoView: View {
    let repo: Repo
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        ScrollView {
            Text(repo.name)
                .bold()
                .font(.system(size: 18))
                .padding(.bottom, 6)
            if let description = repo.description {
                HStack {
                    Text(description)
                        .foregroundColor(.gray)
                        .font(.system(size: 14))
                    Spacer()
                }.padding(.bottom, 4)
            }
            
            Divider().padding(.vertical, 2)
            
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
                }.padding(.bottom, 1)
                
                if let language = repo.language {
                    HStack {
                        Text("Language:")
                            .foregroundColor(.gray)
                            .font(.system(size: 12))
                        Text(language)
                            .bold()
                            .font(.system(size: 12))
                        Spacer()
                    }.padding(.bottom, 1)
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
                    }.padding(.bottom, 1)
                }
                
                HStack {
                    Text("Stars:")
                        .foregroundColor(.gray)
                        .font(.system(size: 12))
                    Text("\(repo.starCount.roundedWithAbbreviations)")
                        .bold()
                        .font(.system(size: 12))
                    Spacer()
                }.padding(.bottom, 1)
                
                HStack {
                    Text("Forks:")
                        .foregroundColor(.gray)
                        .font(.system(size: 12))
                    Text("\(repo.forks.roundedWithAbbreviations)")
                        .bold()
                        .font(.system(size: 12))
                    Spacer()
                }.padding(.bottom, 1)
                
                HStack {
                    Text("Issues:")
                        .foregroundColor(.gray)
                        .font(.system(size: 12))
                    Text("\(repo.issueCount.roundedWithAbbreviations)")
                        .bold()
                        .font(.system(size: 12))
                    Spacer()
                }.padding(.bottom, 1)
                
                HStack {
                    Text("Watchers:")
                        .foregroundColor(.gray)
                        .font(.system(size: 12))
                    Text("\(repo.watcherCount.roundedWithAbbreviations)")
                        .bold()
                        .font(.system(size: 12))
                    Spacer()
                }
            }
            
            Divider().padding(.vertical, 4)
            
            NavigationLink(
                destination: Markdown(markdownViewModel: RealMarkdownViewModel(appState: appState), username: repo.ownerName, repoName: repo.name)) {
                    Text("View Readme")
            }.padding(.bottom, 4)
            
            NavigationLink(
                destination: IssuesList(issueViewModel: RealIssuesViewModel(appState: appState), repoName: repo.name, authorName: repo.ownerName)) {
                    Text("View Issues")
            }.padding(.bottom, 4)
            
            NavigationLink(
                destination: CommitsList(commitViewModel: RealCommitsViewModel(appState: appState), authorName: repo.ownerName, repoName: repo.name)) {
                    Text("View Commits")
            }.padding(.bottom, 4)
            
            NavigationLink(
                destination: UserProfile(profileViewModel: RealProfileViewModel(appState: appState), username: repo.ownerName)) {
                    Text("View Author")
            }
        }
        .navigationTitle(repo.name)
        .padding(.horizontal, 6)
    }
}

struct RepoView_Previews: PreviewProvider {
    static var previews: some View {
        RepoView(repo: Repo(name: "playify", ownerName: "iberatkaya", issueCount: 0, forks: 2, starCount: 17, watcherCount: 17, description: "This is a test repo description.", language: "Dart", licenseName: "MIT License"))
    }
}
