import SwiftUI

protocol OrganizationViewModel {
    func requestUserOrganizations(username: String) -> Void
}

class RealOrganizationViewModel: ObservableObject, OrganizationViewModel {
    private let appState: AppState
    private let profileRepository = RealProfileRepository()
    
    ///The page counter for the `requestUserOrganizations` function. Used for pagination.
    private var requestUserOrganizationsPage = 1
    
    ///The fetched organizations.
    @Published var organizations: [ProfileUser] = []

    ///Determines whether more data can be fetched. Is false if the response contains no more data.
    @Published var canFetchMore = true

    ///Determines whether a request is being made.
    @Published var loading = true
    
    ///Displays the error string. Is null if an error does not exist.
    @Published var error: String?

    init(appState: AppState) {
        self.appState = appState
    }

    /// Request a user's organizations.
    ///
    /// - Parameters:
    ///     - username: The GitHub user's username.
    func requestUserOrganizations(username: String) {
        if let accessToken = appState.user.accessToken {
            loading = true
            profileRepository.requestUserOrganizations(username: username, accessToken: accessToken, page: requestUserOrganizationsPage, completed: { orgs in
                DispatchQueue.main.async {
                    self.organizations += orgs
                    if orgs.isEmpty {
                        self.canFetchMore = false
                    }
                    self.error = nil
                    self.loading = false
                }
            }, onError: { err in
                DispatchQueue.main.async {
                    self.loading = false
                    self.error = err
                }
            })
            requestUserOrganizationsPage += 1
        }
    }
}
