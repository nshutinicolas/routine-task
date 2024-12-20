//
//  ContentView.swift
//  Routine Task
//
//  Created by Musoni nshuti Nicolas on 20/12/2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        AppView()
    }
}

#Preview {
    ContentView()
		.environmentObject(AppCoordinator())
}
