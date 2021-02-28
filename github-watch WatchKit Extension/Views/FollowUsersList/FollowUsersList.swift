//
//  UsersList.swift
//  github-watch WatchKit Extension
//
//  Created by Ibrahim Berat Kaya on 28.02.2021.
//

import SwiftUI

struct UsersList: View {
    @EnvironmentObject var appState: AppState
    @ObservedObject var usersViewModel: RealUsersViewModel
    let userFollowType: UserFollowType
    let username: String

    init(usersViewModel: RealUsersViewModel, username: String, userFollowType: UserFollowType) {
        self.usersViewModel = usersViewModel
        self.username = username
        self.userFollowType = userFollowType
    }

    func fetchUsers() {
        usersViewModel.requestUserFollowersOrFollowings(username: username, userFollowType: userFollowType)
    }
    
    func mapFollowTypeToString() -> String {
        if userFollowType == UserFollowType.followers {
            return "Followers"
        }
        if userFollowType == UserFollowType.following {
            return "Following"
        }
        return ""
    }

    var body: some View {
        ScrollView {
            Text(mapFollowTypeToString()).bold()
            Divider().padding(.vertical, 4)
            ForEach(usersViewModel.users, id: \.id) { org in
                NavigationLink(destination: UserProfile(profileViewModel: RealProfileViewModel(appState: appState), username: org.username!)) {
                    MiniUserView(user: org)
                }
            }
            if usersViewModel.users.count > 0 && usersViewModel.canFetchMore {
                BottomNavRow(buttonClick: fetchUsers, loading: $usersViewModel.loading)
            }
            if let error = usersViewModel.error {
                Text(error).padding(.horizontal, 4)
            }
            if usersViewModel.loading {
                ProgressView()
            }
        }
        .navigationTitle(mapFollowTypeToString())
        .padding(.horizontal, 2)
        .onAppear(perform: {
            fetchUsers()
        })
    }
}

struct UsersList_Previews: PreviewProvider {
    static var previews: some View {
        UsersList(usersViewModel: RealUsersViewModel(appState: AppState()), username: "iberatkaya", userFollowType: UserFollowType.followers)
    }
}
