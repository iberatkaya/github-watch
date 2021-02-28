import SwiftUI

struct Home: View {
    @EnvironmentObject var appState: AppState
    @ObservedObject var authViewModel: RealAuthViewModel
    
    init(authViewModel: RealAuthViewModel) {
        self.authViewModel = authViewModel
    }
    
    var body: some View {
        ScrollView {
            if appState.user.accessToken == nil {
                Image("Logo")
                Text("Welcome to Git Watch")
                    .font(.system(size: 20))
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
                Image("Logo")
                Text("Welcome to Git Watch")
                    .font(.system(size: 20))
                    .foregroundColor(.gray)
                    .bold()
                    .padding(.bottom, 16)
                HStack {
                    Text("You are logged in!")
                        .font(.system(size: 16))
                    Image(systemName: "checkmark.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.blue)
                        .frame(width: 16, height: 16)
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
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home(authViewModel: RealAuthViewModel(appState: AppState())).environmentObject(AppState())
    }
}
