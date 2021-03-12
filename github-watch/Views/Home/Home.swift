import SwiftUI

struct Home: View {
    @EnvironmentObject var appState: AppState
    @EnvironmentObject var connectivityController: ConnectivityController
    @ObservedObject var authViewModel: RealAuthViewModel

    init(authViewModel: RealAuthViewModel) {
        self.authViewModel = authViewModel
    }

    var body: some View {
        ScrollView {
            Image("Logo")
                .resizable()
                .scaledToFit()
                .frame(height: 250)
            
            Text("Welcome to Git Watch")
                .font(.system(size: 22))
                .bold()
                .padding(.bottom, 2)
            
            if appState.user.accessToken == nil {
                Text("Please login while Git Watch is open on your Apple Watch!")
                    .font(.system(size: 12))
                    .foregroundColor(.gray)
                    .bold()
                    .padding(.bottom, 16)
                
                NavigationLink(destination: GitHubAuth(authViewModel: authViewModel)) {
                    Text("Login To GitHub!")
                        .font(.system(size: 16))
                        .bold()
                        .padding(.vertical, 12)
                        .padding(.horizontal, 16)
                        .background(RoundedRectangle(cornerRadius: 16, style: .continuous).fill(Color.blue.opacity(0.1)))
                        .foregroundColor(.blue)
                }
            } else {
                HStack {
                    Text("You are logged in!")
                        .foregroundColor(.gray)
                        .font(.system(size: 16))
                    Image(systemName: "checkmark.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.blue)
                        .frame(width: 16, height: 16)
                }.padding(.bottom, 16)
                
                Button(action: {
                    connectivityController.sendOAuthTokenToWatch(token: appState.user.accessToken!)
                }) {
                    Text("Resend OAuth Token")
                        .font(.system(size: 16))
                        .bold()
                        .padding(.vertical, 12)
                        .padding(.horizontal, 16)
                        .background(RoundedRectangle(cornerRadius: 16, style: .continuous).fill(Color.blue.opacity(0.1)))
                        .foregroundColor(.blue)
                }.padding(.bottom, 4)
                
                Button(action: {
                    authViewModel.signOut()
                }) {
                    Text("Sign Out")
                        .font(.system(size: 16))
                        .bold()
                        .padding(.vertical, 12)
                        .padding(.horizontal, 16)
                        .background(RoundedRectangle(cornerRadius: 16, style: .continuous).fill(Color.blue.opacity(0.1)))
                        .foregroundColor(.blue)
                }
            }
        }.padding(.horizontal, 12)
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home(authViewModel: RealAuthViewModel(appState: AppState())).environmentObject(AppState())
    }
}
