import SwiftUI

struct SearchUsers: View {
    @State private var name: String  = ""
    @EnvironmentObject var appState: AppState
    
    
    var body: some View {
        ScrollView {
            TextField("Search Users",text: $name)
            NavigationLink(destination: SearchUsersList(name:name,usersViewModel: RealUsersViewModel(
            appState: appState))){
                Text("Submit")
            }.disabled(name == "")
        }.padding(.horizontal,2)
    }
    
}

struct SearchUsers_Previews: PreviewProvider {
    static var previews: some View {
        SearchUsers()
    }
}
