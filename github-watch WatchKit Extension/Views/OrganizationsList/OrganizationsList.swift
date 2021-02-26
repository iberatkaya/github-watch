import SwiftUI

struct OrganizationsList: View {
    @ObservedObject var organizationViewModel: RealOrganizationViewModel
    @EnvironmentObject var appState: AppState
    let username: String

    init(organizationViewModel: RealOrganizationViewModel, username: String) {
        self.username = username
        self.organizationViewModel = organizationViewModel
    }

    func fetchOrganizations() {
        organizationViewModel.requestUserOrganizations(username: username)
    }

    var body: some View {
        ScrollView {
            Text("\(username)").bold()
            Divider().padding(.vertical, 4)
            ForEach(organizationViewModel.organizations, id: \.id) { org in
                NavigationLink(destination: UserProfile(profileViewModel: RealProfileViewModel(appState: appState), username: org.username!)) {
                    MiniUserView(user: org)
                }
            }
            if organizationViewModel.organizations.count > 0 && organizationViewModel.canFetchMore {
                BottomNavRow(buttonClick: fetchOrganizations, loading: $organizationViewModel.loading)
            }
            if let error = organizationViewModel.error {
                Text(error).padding(.horizontal, 4)
            }
            if organizationViewModel.loading {
                ProgressView()
            }
        }
        .navigationTitle(username)
        .padding(.horizontal, 2)
        .onAppear(perform: {
            fetchOrganizations()
        })
    }
}

struct OrganizationsListList_Previews: PreviewProvider {
    static var previews: some View {
        OrganizationsList(organizationViewModel: RealOrganizationViewModel(appState: AppState()), username: "iberatkaya")
    }
}
