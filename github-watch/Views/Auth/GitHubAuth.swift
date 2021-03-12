import SwiftUI
import WebView

struct GitHubAuth: View {
    @StateObject var webViewStore = WebViewStore()
    @EnvironmentObject var connectivityController: ConnectivityController
    @ObservedObject var authViewModel: RealAuthViewModel
    @Environment(\.presentationMode) var presentation
    @State var error: String?
    @State var errorExists = false

    init(authViewModel: RealAuthViewModel) {
        self.authViewModel = authViewModel
    }

    var body: some View {
        WebView(webView: webViewStore.webView)
            .navigationBarTitle(Text(verbatim: webViewStore.url?.absoluteString ?? ""), displayMode: .inline)
            .onAppear {
                self.webViewStore.webView.load(URLRequest(url: URL(string: "https://github.com/login/oauth/authorize?scope=read:user%20repo%20read:org&client_id=\(clientID)&allow_signup=false&state=abcde")!))
            }.onChange(of: webViewStore.url, perform: { value in
                if value != nil, value!.queryParameters?["code"] != nil {
                    guard let code = value!.queryParameters!["code"] else {
                        return
                    }

                    authViewModel.requestAccessToken(code: code, completed: { accessToken in
                        if let accessToken = accessToken {
                            connectivityController.sendOAuthTokenToWatch(token: accessToken, onError: { err in
                                error = err
                                errorExists = true
                            })
                        }
                        DispatchQueue.main.async {
                            presentation.wrappedValue.dismiss()
                        }
                    })
                }
            }).alert(isPresented: $errorExists) {
                Alert(title: Text("An error occured"), message: Text(error ?? ""), dismissButton: .default(Text("OK!")))
            }
    }
}
