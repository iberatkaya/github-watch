import SwiftUI
import WebView

struct GitHubAuth: View {
    @StateObject var webViewStore = WebViewStore()
    
    @Environment(\.presentationMode) var presentation
    @EnvironmentObject var authInteractor: RealAuthInteractor
    @EnvironmentObject var connectivityController: ConnectivityController
    
    var body: some View {
        NavigationView {
            WebView(webView: webViewStore.webView)
                .navigationBarTitle(Text(verbatim: webViewStore.url?.absoluteString ?? ""), displayMode: .inline)
        }.onAppear {
            self.webViewStore.webView.load(URLRequest(url: URL(string: "https://github.com/login/oauth/authorize?scope=read:user%20repo&client_id=\(clientID)&allow_signup=false&state=abcde")!))
        }.onChange(of: webViewStore.url, perform: { value in
            if(value != nil && value!.queryParameters?["code"] != nil){
                guard let code = value!.queryParameters!["code"] else {
                    return
                }
                
                authInteractor.requestAccessToken(code: code, completed: { accessToken in
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
