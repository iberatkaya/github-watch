import SwiftUI

protocol ProfileInteractor {
    func requestProfile(username: String, completed: @escaping (ProfileUser) -> Void, onError: @escaping (String) -> Void) -> Void
    func requestMyProfile(completed: @escaping (ProfileUser) -> Void, onError: @escaping (String) -> Void) -> Void
    func requestUserOrganizations(username: String, completed: @escaping ([ProfileUser]) -> Void, onError: @escaping (String) -> Void) -> Void
}

class RealProfileInteractor: ObservableObject, ProfileInteractor {
    private let appState: AppState
    private let profileRepository = RealProfileRepository()
    private var requestUserOrganizationsPage = 1

    init(appState: AppState) {
        self.appState = appState
    }
    
    func resetRequestUserOrganizationsPage() {
        requestUserOrganizationsPage = 1
    }

    /// Request a the signed in user's profile using the access token.
    ///
    /// - Parameters:
    ///     - completed: The clouse to call when the user profile is fetched. Returns nil if an error occurs.
    ///     - onError: The clouse to call when an error occurs. Returns the error string.
    func requestMyProfile(completed: @escaping (ProfileUser) -> Void, onError: @escaping (String) -> Void = {_ in }) {
        if let accessToken = appState.user.accessToken {
            profileRepository.requestMyProfile(accessToken: accessToken, completed: completed, onError: onError)
        }
    }

    /// Request a user's profile.
    ///
    /// - Parameters:
    ///     - username: The GitHub user's username.
    ///     - completed: The clouse to call when the user profile is fetched. Returns nil if an error occurs.
    ///     - onError: The clouse to call when an error occurs. Returns the error string.
    func requestProfile(username: String, completed: @escaping (ProfileUser) -> Void, onError: @escaping (String) -> Void = {_ in }) {
        if let accessToken = appState.user.accessToken {
            if username == appState.user.username {
                profileRepository.requestMyProfile(accessToken: accessToken, completed: completed, onError: onError)
            } else {
                profileRepository.requestProfile(username: username, accessToken: accessToken, completed: completed, onError: onError)
            }
        }
    }

    /// Request a user's organizations.
    ///
    /// - Parameters:
    ///     - username: The GitHub user's username.
    ///     - accessToken: The GitHub user's OAuth accessToken.
    ///     - completed: The clouse to call when the user's organizations are fetched. Returns nil if an error occurs.
    ///     - onError: The clouse to call when an error occurs. Returns the error string.
    func requestUserOrganizations(username: String, completed: @escaping ([ProfileUser]) -> Void, onError: @escaping (String) -> Void = {_ in }) {
        if let accessToken = appState.user.accessToken {
            profileRepository.requestUserOrganizations(username: username, accessToken: accessToken, page: requestUserOrganizationsPage, completed: completed, onError: onError)
            requestUserOrganizationsPage += 1
        }
    }
}
