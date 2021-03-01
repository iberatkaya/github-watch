//
//  ContentView.swift
//  github-watch WatchKit Extension
//
//  Created by Ibrahim Berat Kaya on 22.02.2021.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var appState: AppState

    var body: some View {
        Home(authViewModel: RealAuthViewModel(appState: appState))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
