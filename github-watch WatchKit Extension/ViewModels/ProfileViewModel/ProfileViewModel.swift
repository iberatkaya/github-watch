import SwiftUI

protocol ProfileViewModel {
    func requestProfile(username: String) -> Void
    func requestMyProfile() -> Void
}

class RealProfileViewModel: ObservableObject, ProfileViewModel {
    private let appState: AppState
    private let profileRepository = RealProfileRepository()
    
    ///The user's profile data. It is null initially and is set when the user is fetched.
    @Published var profileUser: ProfileUser?
    
    ///Determines whether a request is being made.
    @Published var loading = true
    
    ///Displays the error string. Is null if an error does not exist.
    @Published var error: String?

    init(appState: AppState) {
        self.appState = appState
    }
    
    /// Request a the signed in user's profile using the access token.
    func requestMyProfile() {
        if let accessToken = appState.user.accessToken {
            loading = true
            profileRepository.requestMyProfile(accessToken: accessToken, completed: {pUser in
                DispatchQueue.main.async {
                    self.profileUser = pUser
                    self.loading = false
                    self.error = nil
                }
            }, onError: { err in
                DispatchQueue.main.async {
                    self.loading = false
                    self.error = err
                }
            })
        }
    }

    /// Request a user's profile.
    ///
    /// - Parameters:
    ///     - username: The GitHub user's username.
    func requestProfile(username: String) {
        if let accessToken = appState.user.accessToken {
            loading = true
            if username == appState.user.username {
                profileRepository.requestMyProfile(accessToken: accessToken, completed: {
                    pUser in
                    DispatchQueue.main.async {
                        self.profileUser = pUser
                        self.loading = false
                        self.error = nil
                    }
                }, onError: { err in
                    DispatchQueue.main.async {
                        self.loading = false
                        self.error = err
                    }
                })
            } else {
                profileRepository.requestProfile(username: username, accessToken: accessToken, completed: {
                    pUser in
                    DispatchQueue.main.async {
                        self.profileUser = pUser
                        self.loading = false
                        self.error = nil
                    }
                }, onError: { err in
                    DispatchQueue.main.async {
                        self.loading = false
                        self.error = err
                    }
                })
            }
        }
    }
}
