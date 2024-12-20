//
//  TaskDetails.swift
//  Routine Task
//
//  Created by Musoni nshuti Nicolas on 20/12/2024.
//

import SwiftUI

struct TaskItem: Identifiable, Equatable {
	let id: String = UUID().uuidString
	var images: [String]? = nil
	let title: String
	var description: String?
	var benefits: [String]? = nil
}

struct TaskDetails: View {
	@Environment(\.dismiss) var dismiss
	@State private var showAddToListSheet: Bool = false
	@State private var selectedTasks = [TaskItem]()
	
	private let title: String
	
	private let mockTaskItems: [TaskItem] = [
		.init(images: ["hydration", "drinks"], title: "Drink a Glass of Water", description: "Start with a full glass to rehydrate after sleep", benefits: ["Hydration", "Health"]),
		.init(title: "Deep Breathing Exercise", description: "Practice deep breathinh for 5 minutes", benefits: ["Breathing", "mindfulness", "Calm"]),
		.init(title: "10-15 minutes of light exercise to energize", description: ""),
		.init(title: "Short Walk or Jog", description: "Go outside for fresh air and movement", benefits: ["Outdoor", "Movement"])
	]
	
	init(title: String) {
		self.title = title
	}
	
    var body: some View {
		VStack(spacing: 0) {
			// Header
			header
				.padding(.horizontal)
			
			ScrollView {
				VStack(spacing: 12) {
					VStack(spacing: 12) {
						Text("Wake-Up and Hydration")
							.font(.cardoRegular(size: 28))
							.frame(maxWidth: .infinity, alignment: .leading)
							.listRowSeparator(.hidden)
						Divider()
					}
					LazyVStack(spacing: 12) {
						ForEach(mockTaskItems) { task in
							TaskCardView(task: task)
						}
					}
				}
				.padding(.horizontal)
			}
			.scrollIndicators(.hidden)
		}
		.safeAreaInset(edge: .bottom) {
			// MARK: Add to List button
			HStack {
				Spacer()
				Button {
					showAddToListSheet = true
				} label: {
					HStack {
						Image(systemName: "plus")
							.font(.title3)
							.fontWeight(.semibold)
						Text("ADD TO LIST")
							.font(.karlRegular(size: 14))
					}
					.padding()
				}
				.foregroundStyle(.white)
				.background(.buttonBlue)
				.clipShape(.capsule)
			}
			.padding(.trailing, 24)
		}
		.sheet(isPresented: $showAddToListSheet) {
			BottomSheetContent()
				.presentationDetents([.medium])
		}
    }
	
	// MARK: Header
	var header: some View {
		HStack(spacing: 12) {
			Image(.backIcon)
				.onTapGesture {
					dismiss()
				}
			
			Text(title)
				.font(.karlRegular(size: 14))
				.frame(maxWidth: .infinity, alignment: .leading)
			Button {
				selectedTasks = selectedTasks.count == .zero ? mockTaskItems : []
			} label: {
				if selectedTasks.count > .zero {
					Text("Cancel")
						.fontWeight(.semibold)
						.foregroundStyle(.gray)
				} else {
					Text("Select All")
						.fontWeight(.semibold)
						.foregroundStyle(.white)
				}
			}
			.padding(.horizontal, 13)
			.padding(.vertical, 7)
			.background(selectedTasks.count > .zero ? .gray.opacity(0.4) : .skyBlue)
			.clipShape(.capsule)
		}
		.frame(minHeight: 56)
		.overlay(alignment: .bottom) {
			Divider()
		}
	}
	
	// MARK: Item Card
	@ViewBuilder
	private func TaskCardView(task: TaskItem) -> some View {
		let isSelected = selectedTasks.contains(where: { $0 == task})
		VStack(spacing: 16) {
			if let images = task.images {
				Rectangle()
					.fill(Color.clear)
					.frame(height: 237)
					.overlay {
						ImageCarousel(images: images)
					}
					.cornerRadius(.init(width: 12, height: 12), corners: [.topLeft, .topRight])
			}
			HStack(alignment: .top) {
				VStack(alignment: .leading, spacing: 6) {
					Text(task.title)
						.font(.cardoBold(size: 18))
					if let description = task.description {
						Text(description)
							.font(.system(size: 14))
							.italic()
							.frame(maxWidth: .infinity, alignment: .leading)
					}
					if let benefits = task.benefits {
						Text(benefits.joined(separator: ", "))
							.font(.system(size: 14))
							.foregroundStyle(.deepBlue)
					}
				}
				.frame(maxWidth: .infinity, alignment: .leading)
				Circle()
					.fill(isSelected ? .skyBlue : Color.skyBlue.opacity(0.15))
					.frame(width: 38, height: 38)
					.overlay {
						if selectedTasks.contains(where: { $0 == task}) {
							Image(.check)
								.resizable()
								.padding(12)
						} else {
							Image(.plus)
								.resizable()
								.frame(width: 16, height: 16)
						}
					}
					.onTapGesture {
						if isSelected {
							selectedTasks = selectedTasks.filter({ $0 != task })
						} else {
							selectedTasks.append(task)
						}
					}
			}
			.padding(16)
		}
		.padding(.bottom, 4)
		.background(.white)
		.cornerRadius(20)
		.shadow(color: .skyBlue.opacity(0.1), radius: 6)
	}
	
	// MARK: Bottom sheet content
	@ViewBuilder
	private func BottomSheetContent() -> some View {
		VStack {
			HStack {
				Text("MY LISTS")
					.font(.karlRegular(size: 14))
					.frame(maxWidth: .infinity, alignment: .leading)
				Image(systemName: "xmark")
					.font(.caption)
					.foregroundStyle(.secondary)
					.padding(8)
					.background(.tertiary.opacity(0.5))
					.clipShape(.circle)
					.onTapGesture {
						showAddToListSheet = false
					}
			}
			.padding(.top, 16)
			ScrollView {
				BottomSheetItemCard(title: "ADD TO NEW LIST", icon: "plus")
				
				BottomSheetItemCard(title: "ADD TO FAVORITES", icon: "star", footnote: "23 Items", hasDisclosureIcon: true)
				
				BottomSheetItemCard(title: "MORNING TASKS", icon: "sun", footnote: "10 Items", hasDisclosureIcon: true)
				
				BottomSheetItemCard(title: "DAILY TASKS", icon: "pen", footnote: "1 Item", hasDisclosureIcon: true)
			}
			.scrollIndicators(.hidden)
		}
		.padding(.horizontal, 18)
		.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
	}
	
	// MARK: Bottom sheet Icon Image
	@ViewBuilder
	private func ImageIconCard(for icon: String) -> some View {
		Image(icon)
			.resizable()
			.renderingMode(.template)
			.aspectRatio(contentMode: .fit)
			.frame(width: 21, height: 24)
			.foregroundStyle(.buttonBlue.opacity(0.95))
			.frame(width: 58, height: 55)
			.cornerRadius(6)
			.background(.buttonBlue.opacity(0.05))
	}
	
	@ViewBuilder
	private func BottomSheetItemCard(title: String, icon: String, footnote: String? = nil, hasDisclosureIcon: Bool = false) -> some View {
		HStack(spacing: 16) {
			ImageIconCard(for: icon)
			VStack(alignment: .leading) {
				Text(title)
					.font(.karlRegular(size: 14))
				if let footnote {
					Text(footnote)
						.font(.footnote)
				}
			}
			.frame(maxWidth: .infinity, alignment: .leading)
			
			if hasDisclosureIcon {
				Image(.backIcon)
					.rotationEffect(.degrees(180))
					.padding(.horizontal)
			}
		}
		.frame(maxWidth: .infinity, alignment: .leading)
	}
}

#Preview {
    TaskDetails(title: "DETAILED MORNING ROUTINE TASKS")
}
