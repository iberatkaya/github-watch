//
//  ContentView.swift
//  github-watch WatchKit Extension
//
//  Created by Ibrahim Berat Kaya on 22.02.2021.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var profileInteractor: RealProfileInteractor
    @EnvironmentObject var connectivityController: ConnectivityController
    @EnvironmentObject var authInteractor: RealAuthInteractor
    @EnvironmentObject var repoInteractor: RealRepoInteractor
    @EnvironmentObject var appState: AppState
    
    
    var body: some View {
        Home().environmentObject(profileInteractor).environmentObject(connectivityController).environmentObject(authInteractor).environmentObject(repoInteractor)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
