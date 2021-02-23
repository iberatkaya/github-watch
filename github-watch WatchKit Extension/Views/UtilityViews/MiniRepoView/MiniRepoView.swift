import SwiftUI

struct MiniRepoView: View {
    let repo: Repo
    
    var body: some View {
        ScrollView {
            Text(repo.name)
                .bold()
                .font(.system(size: 16))
                .padding(.bottom, 4)
            
            if let description = repo.description {
                HStack {
                    Text(description)
                        .lineLimit(3)
                        .foregroundColor(.gray)
                        .font(.system(size: 12))
                    Spacer()
                }.padding(.bottom, 2)
            }
            
            VStack {
                HStack {
                    Text("Owner:")
                        .foregroundColor(.gray)
                        .font(.system(size: 10))
                    Text("@\(repo.ownerName)")
                        .bold()
                        .font(.system(size: 10))
                    Spacer()
                }
                    
                if let language = repo.language {
                    HStack {
                        Text("Language:")
                            .foregroundColor(.gray)
                            .font(.system(size: 10))
                        Text(language)
                            .bold()
                            .font(.system(size: 10))
                        Spacer()
                    }
                }
            }.padding(.bottom, 2)
            
            HStack {
                HStack {
                    Text("Stars:")
                        .foregroundColor(.gray)
                        .font(.system(size: 9))
                    Text("\(repo.starCount.roundedWithAbbreviations)")
                        .bold()
                        .font(.system(size: 9))
                    Spacer()
                }
                    
                HStack {
                    Text("Forks:")
                        .foregroundColor(.gray)
                        .font(.system(size: 9))
                    Text("\(repo.forks.roundedWithAbbreviations)")
                        .bold()
                        .font(.system(size: 9))
                    Spacer()
                }
            }
            
            HStack {
                Text("Issues:")
                    .foregroundColor(.gray)
                    .font(.system(size: 9))
                Text("\(repo.issueCount.roundedWithAbbreviations)")
                    .bold()
                    .font(.system(size: 9))
                Spacer()
            }
        }.padding(.horizontal, 2)
    }
}

struct MiniRepoView_Previews: PreviewProvider {
    static var previews: some View {
        MiniRepoView(repo: Repo(name: "playify", ownerName: "iberatkaya", issueCount: 2340, forks: 2234, starCount: 173453, watcherCount: 17324, description: "This is a test repo description.", language: "Dart", licenseName: "MIT License"))
    }
}
