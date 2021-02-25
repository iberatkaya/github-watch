import SwiftUI

struct OrganizationsList: View {
    @EnvironmentObject var profileInteractor: RealProfileInteractor
    let username: String
    @State var loading = false
    @State var organizations: [ProfileUser] = []
    @State var canFetchMore = true
    @State var error: String?

    init(username: String) {
        self.username = username
    }

    func fetchReposByName() {
        loading = true
        profileInteractor.requestUserOrganizations(username: username, completed: { orgs in
            DispatchQueue.main.async {
                organizations += orgs
                if orgs.isEmpty {
                    canFetchMore = false
                }
                error = nil
                loading = false
            }
        }, onError: { err in
            DispatchQueue.main.async {
                loading = false
                error = err
            }
        })
    }

    var body: some View {
        ScrollView {
            Text("\(username)").bold()
            Divider().padding(.vertical, 4)
            ForEach(organizations, id: \.id) { org in
                NavigationLink(destination: UserProfile(username: org.username!)) {
                    MiniUserView(user: org)
                }
            }
            if organizations.count > 0 && canFetchMore {
                BottomNavRow(buttonClick: fetchReposByName, loading: $loading)
            }
            if let error = error {
                Text(error).padding(.horizontal, 4)
            }
            if loading {
                ProgressView()
            }
        }
        .navigationTitle(username)
        .padding(.horizontal, 2)
        .onAppear(perform: {
            profileInteractor.resetRequestUserOrganizationsPage()
            fetchReposByName()
        })
    }
}

struct OrganizationsListList_Previews: PreviewProvider {
    static var previews: some View {
        SearchReposList(name: "playify")
    }
}
