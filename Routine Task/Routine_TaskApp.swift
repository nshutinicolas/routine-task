//
//  Routine_TaskApp.swift
//  Routine Task
//
//  Created by Musoni nshuti Nicolas on 20/12/2024.
//

import SwiftUI

@main
struct Routine_TaskApp: App {
	
	@StateObject private var coordinator = AppCoordinator()
	
    var body: some Scene {
        WindowGroup {
            ContentView()
				.environmentObject(coordinator) // Registering App coordinator
        }
    }
}
