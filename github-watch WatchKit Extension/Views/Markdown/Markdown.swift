import SwiftUI
import Parma

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
                    ProgressView()
                    Text("Loading...")
                }
            }
            if let markdown = markdown {
                Parma(markdown)
            } else if (!downloading) {
                Text("README not found!")
            }
        }
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
        Parma("""
## Author

👤 **Ibrahim Berat Kaya**

- Github: [@iberatkaya](https://github.com/iberatkaya)
- LinkedIn: [@ibrahim-berat-kaya](https://linkedin.com/in/ibrahim-berat-kaya)

## 🤝 Contributing
""")
    }
}
