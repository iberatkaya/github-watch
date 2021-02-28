import SwiftUI

struct SearchUsersList: View {
    @ObservedObject var usersViewModel: RealUsersViewModel
    @EnvironmentObject var appState: AppState
    let name: String
    
    init(name: String, usersViewModel: RealUsersViewModel ) {
        self.name = name
        self.usersViewModel = usersViewModel
    }
    
    func fetchUser(){
        usersViewModel.requestSearchUsersByName(username: name)
    }
    
    var body: some View {
        ScrollView {
            Text("\(name)").bold()
            Divider().padding(.vertical, 4)
            ForEach(usersViewModel.users, id: \.id) { org in
                NavigationLink(destination: UserProfile(profileViewModel: RealProfileViewModel(appState: appState), username: org.username!)) {
                    MiniUserView(user: org)
                }
            }
            if usersViewModel.users.count > 0 && usersViewModel.canFetchMore {
                BottomNavRow(buttonClick: fetchUser, loading: $usersViewModel.loading)
            }
            if let error = usersViewModel.error {
                Text(error).padding(.horizontal, 4)
            }
            if usersViewModel.loading {
                ProgressView()
            }
        }
        .navigationTitle(name)
        .padding(.horizontal, 2)
        .onAppear(perform: {
            fetchUser()
        })
    }
}

struct SearchUsersList_Previews: PreviewProvider {
    static var previews: some View {
        SearchUsersList(name: "Hello",usersViewModel: RealUsersViewModel(appState: AppState()))
    }
}
