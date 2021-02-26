import Parma
import SwiftUI

struct Markdown: View {
    var username: String
    var repoName: String
    @State var downloading = true
    @State var markdown: String?
    @ObservedObject var markdownViewModel: RealMarkdownViewModel

    init(markdownViewModel: RealMarkdownViewModel, username: String, repoName: String) {
        self.username = username
        self.repoName = repoName
        self.markdownViewModel = markdownViewModel
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
            markdownViewModel.requestREADME(username: username, repo: repoName)
        })
    }
}

struct Markdown_Previews: PreviewProvider {
    static var previews: some View {
        Markdown(markdownViewModel: RealMarkdownViewModel(appState: AppState()), username: "iberatkaya", repoName: "playify")
    }
}
