import Parma
import SwiftUI

struct Markdown: View {
    var username: String
    var repoName: String
    @State var downloading = true
    @State var markdown: String?
    @EnvironmentObject var markdownInteractor: RealMarkdownInteractor

    init(username: String, repoName: String) {
        self.username = username
        self.repoName = repoName
    }

    var body: some View {
        ScrollView {
            if downloading {
                VStack {
                    ProgressView().padding(.bottom, 4)
                    Text("Loading...")
                }
            }
            if let markdown = markdown {
                Parma(markdown)
            } else if !downloading {
                Text("README not found!")
            }
        }
        .navigationTitle(repoName)
        .padding(.horizontal, 8)
        .onAppear(perform: {
            markdownInteractor.requestREADME(username: username, repo: repoName, completed: { markdownText in
                DispatchQueue.main.async {
                    downloading = false
                    markdown = markdownText
                }
            })
        })
    }
}

struct Markdown_Previews: PreviewProvider {
    static var previews: some View {
        Markdown(username: "iberatkaya", repoName: "playify")
    }
}
