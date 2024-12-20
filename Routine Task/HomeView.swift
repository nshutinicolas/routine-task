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
}

struct HomeView: View {
	private var mockTasks: [TaskModel] = [
		.init(image: "image-1", title: "DETAILED MORNING ROUTINE TASKS"),
		.init(image: "image-2", title: "DAILY WORKDAY FOCUS GOALS AND TASKS TO KEEP YOU ON TRACK"),
		.init(image: "image-3", title: "EVENING WIND-DOWN ROUTINE GOALS"),
		.init(image: "image-4", title: "COMPREHENSIVE SLEEP ROUTINE GOALS")
	]
	
    var body: some View {
		VStack(spacing: 0) {
			header
				.padding(.horizontal)
			
			List {
				ForEach(mockTasks, id: \.hashValue) { task in
					TaskItemView(for: task)
				}
			}
			.listStyle(.plain)
		}
		.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    }
	
	var header: some View {
		VStack {
			Text("Home")
				.font(.system(size: 25))
		}
		.frame(height: 56)
		.frame(maxWidth: .infinity)
		.overlay(alignment: .bottom) {
			Divider()
		}
	}
	
	@ViewBuilder
	private func TaskItemView(for task: TaskModel) -> some View {
		HStack {
			Rectangle()
				.fill(Color.clear)
				.frame(width: 92, height: 92)
				.overlay {
					Image(task.image)
						.resizable()
				}
			Text(task.title)
				.font(.karlRegular(size: 14))
				.padding(.horizontal, 5)
		}
		.frame(maxWidth: .infinity, alignment: .leading)
		.background(.skyBlue.opacity(0.15))
		.clipShape(.rect(cornerRadius: 6))
		.listRowSeparator(.hidden)
	}
}

#Preview {
    HomeView()
}
