//
//  AppView.swift
//  Routine Task
//
//  Created by Musoni nshuti Nicolas on 20/12/2024.
//

import SwiftUI

// App Coordinator
class AppCoordinator: ObservableObject {
	@Published var path = NavigationPath()
}

enum Tab: String, CaseIterable {
	case home
	case list
	case profile
	
	var icon: String {
		switch self {
		case .home: return "house"
		case .list: return "checklist"
		case .profile: return "person"
		}
	}
}

struct AppView: View {
	@EnvironmentObject private var coordinator: AppCoordinator
	@State private var selectedTab: Tab = .home
	@Namespace private var tabAnimation
	
    var body: some View {
		NavigationStack(path: $coordinator.path) {
			VStack(spacing: 0) {
				TabView(selection: $selectedTab) {
					HomeView()
						.tag(Tab.home)
					TaskListView()
						.tag(Tab.list)
					ProfileView()
						.tag(Tab.profile)
				}
				// MARK: Custom Tab View
				HStack(spacing: 16) {
					ForEach(Tab.allCases, id: \.rawValue) { tab in
						TabItem(tab: tab)
							.onTapGesture {
								withAnimation {
									selectedTab = tab
								}
							}
					}
				}
				.padding(.vertical)
				.padding(.horizontal, 16)
				.background(.skyBlue.opacity(0.3))
				.clipShape(.capsule)
			}
		}
    }
	
	// TODO: Fix Tab animation
	@ViewBuilder
	private func TabItem(tab: Tab) -> some View {
		Image(systemName: tab.icon)
			.font(.title3)
			.foregroundStyle(.white)
			.padding()
			.background {
				if selectedTab == tab  {
					Circle()
						.fill(Color.skyBlue)
				} else {
					Color.clear
				}
			}
	}
}

struct TaskListView: View {
	var body: some View {
		Text("Task list view")
	}
}

struct ProfileView: View {
	var body: some View {
		Text("Profile View")
	}
}

#Preview {
    AppView()
		.environmentObject(AppCoordinator())
}
