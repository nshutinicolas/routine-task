//
//  HomeView.swift
//  Routine Task
//
//  Created by Musoni nshuti Nicolas on 20/12/2024.
//

import SwiftUI

struct TaskModel: Hashable {
	let image: String
	let title: String
	
	static let mockData: [TaskModel] = [
		.init(image: "image-1", title: "DETAILED MORNING ROUTINE TASKS"),
		.init(image: "image-2", title: "DAILY WORKDAY FOCUS GOALS AND TASKS TO KEEP YOU ON TRACK"),
		.init(image: "image-3", title: "EVENING WIND-DOWN ROUTINE GOALS"),
		.init(image: "image-4", title: "COMPREHENSIVE SLEEP ROUTINE GOALS")
	]
}

struct HomeView: View {
	@EnvironmentObject private var coordinator: AppCoordinator
	
    var body: some View {
		VStack(spacing: 0) {
			header
			
			ScrollView {
				LazyVStack(spacing: 16) {
					ForEach(TaskModel.mockData, id: \.hashValue) { task in
						TaskItemCardView(for: task)
							.onTapGesture {
								coordinator.path.append(task)
							}
					}
				}
				.padding(.top, 20)
			}
			.scrollIndicators(.hidden)
		}
		.padding(.horizontal, 20)
		.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
		.navigationDestination(for: TaskModel.self) { item in
			TaskDetails(title: item.title)
		}
    }
	
	// MARK: Header
	var header: some View {
		VStack {
			Text("Home")
				.font(.system(size: 25))
		}
		.frame(height: 56)
		.frame(maxWidth: .infinity)
		.overlay(alignment: .bottom) {
			Divider()
				.padding(.bottom, 1)
		}
	}
	
	// MARK: Item Card view
	@ViewBuilder
	private func TaskItemCardView(for task: TaskModel) -> some View {
		HStack(spacing: 16) {
			Rectangle()
				.fill(Color.clear)
				.frame(width: 92, height: 92)
				.overlay {
					Image(task.image)
						.resizable()
				}
			Text(task.title)
				.font(.karlRegular(size: 14))
				.padding(.trailing, 15)
				.frame(maxWidth: .infinity, alignment: .leading)
		}
		.frame(maxWidth: .infinity, alignment: .leading)
		.background(.skyBlue.opacity(0.15))
		.clipShape(.rect(cornerRadius: 6))
	}
}

#Preview {
    HomeView()
		.environmentObject(AppCoordinator())
}
