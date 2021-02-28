import SwiftUI
import WebView

struct GitHubAuth: View {
    @StateObject var webViewStore = WebViewStore()
    @ObservedObject var connectivityController: ConnectivityController
    @ObservedObject var authViewModel: RealAuthViewModel
    @Environment(\.presentationMode) var presentation

    init(authViewModel: RealAuthViewModel) {
        self.authViewModel = authViewModel
        self.connectivityController = ConnectivityController()
    }

    var body: some View {
        WebView(webView: webViewStore.webView)
            .navigationBarTitle(Text(verbatim: webViewStore.url?.absoluteString ?? ""), displayMode: .inline)
            .onAppear {
                self.webViewStore.webView.load(URLRequest(url: URL(string: "https://github.com/login/oauth/authorize?scope=read:user%20repo&client_id=\(clientID)&allow_signup=false&state=abcde")!))
            }.onChange(of: webViewStore.url, perform: { value in
                if value != nil, value!.queryParameters?["code"] != nil {
                    guard let code = value!.queryParameters!["code"] else {
                        return
                    }

                    authViewModel.requestAccessToken(code: code, completed: { accessToken in
                        if let accessToken = accessToken {
                            connectivityController.sendOAuthTokenToWatch(token: accessToken)
                        }
                        DispatchQueue.main.async {
                            presentation.wrappedValue.dismiss()
                        }
                    })
                }
            })
    }
}
