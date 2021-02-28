import SwiftUI

protocol UsersViewModel {
    func requestUserFollowersOrFollowings(username: String, userFollowType: UserFollowType) -> Void
}

class RealUsersViewModel: ObservableObject, UsersViewModel {
    private let appState: AppState
    private let profileRepository = RealProfileRepository()
    
    ///The page counter for the `requestUserOrganizations` function. Used for pagination.
    private var requestUserFollowersOrFollowingsPage = 1
    
    ///The fetched users.
    @Published var users: [ProfileUser] = []

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
    ///     - userFollowType: Determines to get the user's followings or followers.
    func requestUserFollowersOrFollowings(username: String, userFollowType: UserFollowType) {
        if let accessToken = appState.user.accessToken {
            loading = true
            profileRepository.requestUserFollowersOrFollowings(username: username, accessToken: accessToken, userFollowType: userFollowType, page: requestUserFollowersOrFollowingsPage, completed: { fetchedUsers in
                DispatchQueue.main.async {
                    self.users += fetchedUsers
                    if fetchedUsers.isEmpty {
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
            requestUserFollowersOrFollowingsPage += 1
        }
    }
}
