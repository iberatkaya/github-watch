//
//  ContentView.swift
//  github-watch WatchKit Extension
//
//  Created by Ibrahim Berat Kaya on 22.02.2021.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var profileInteractor: RealProfileInteractor
    @ObservedObject var connectivityController: ConnectivityController
    @ObservedObject var authInteractor: RealAuthInteractor
    @EnvironmentObject var appState: AppState
    
    init(appState: AppState) {
        profileInteractor = RealProfileInteractor(appState: appState)
        connectivityController = ConnectivityController(appState: appState)
        authInteractor = RealAuthInteractor(appState: appState)
    }
    
    var body: some View {
        Home().environmentObject(profileInteractor).environmentObject(connectivityController).environmentObject(authInteractor)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(appState: AppState())
    }
}
