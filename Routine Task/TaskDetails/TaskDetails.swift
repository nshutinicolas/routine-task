//
//  TaskDetails.swift
//  Routine Task
//
//  Created by Musoni nshuti Nicolas on 20/12/2024.
//

import SwiftUI

struct TaskItem: Identifiable {
	let id: String = UUID().uuidString
	var images: [String]? = nil
	let title: String
	var description: String?
	var benefits: [String]? = nil
}

struct TaskDetails: View {
	@Environment(\.dismiss) var dismiss
	@State private var showAddToListSheet: Bool = false
	
	private let title: String
	
	private let mockTaskItems: [TaskItem] = [
		.init(images: ["hydration", "drinks"], title: "Drink a Glass of Water", description: "Start with a full glass to rehydrate after sleep", benefits: ["Hydration", "Health"]),
		.init(title: "Deep Breathing Exercise", description: "Practice deep breathinh for 5 minutes"),
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
			
			List{
				VStack {
					Text("Wake-Up and Hydration")
						.font(.cardoRegular(size: 28))
						.frame(maxWidth: .infinity, alignment: .leading)
						.listRowSeparator(.hidden)
					Divider()
				}
				ForEach(mockTaskItems) { task in
					TaskItemView(task: task)
						.listRowSeparator(.hidden)
				}
			}
			.scrollIndicators(.hidden)
			.listStyle(.plain)
		}
		.safeAreaInset(edge: .bottom) {
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
			.padding(.horizontal)
		}
		.sheet(isPresented: $showAddToListSheet) {
			VStack {
				HStack {
					Text("MY LISTS")
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
					HStack {
						Image(systemName: "plus")
							.font(.body)
							.frame(width: 58, height: 55)
							.cornerRadius(6)
							.background(.buttonBlue.opacity(0.05))
						Text("ADD TO NEW LIST")
							.font(.karlRegular(size: 14))
					}
					.frame(maxWidth: .infinity, alignment: .leading)
					HStack {
						Image(systemName: "star.fill")
							.font(.body)
							.foregroundStyle(.buttonBlue)
							.frame(width: 58, height: 55)
							.cornerRadius(6)
							.background(.buttonBlue.opacity(0.05))
						VStack(alignment: .leading) {
							Text("ADD TO FAVORITES")
								.font(.karlRegular(size: 14))
							Text("23 Items")
								.font(.footnote)
						}
					}
					.frame(maxWidth: .infinity, alignment: .leading)
					HStack {
						Image(systemName: "gear")
							.font(.body)
							.foregroundStyle(.buttonBlue)
							.frame(width: 58, height: 55)
							.cornerRadius(6)
							.background(.buttonBlue.opacity(0.05))
						VStack(alignment: .leading) {
							Text("MORNING TASKS")
								.font(.karlRegular(size: 14))
							Text("10 Items")
								.font(.footnote)
						}
					}
					.frame(maxWidth: .infinity, alignment: .leading)
					HStack {
						Image(systemName: "pencil")
							.font(.body)
							.foregroundStyle(.buttonBlue)
							.frame(width: 58, height: 55)
							.cornerRadius(6)
							.background(.buttonBlue.opacity(0.05))
						VStack(alignment: .leading) {
							Text("DAILY TASKS")
								.font(.karlRegular(size: 14))
							Text("1 Item")
								.font(.footnote)
						}
					}
					.frame(maxWidth: .infinity, alignment: .leading)
				}
				.scrollIndicators(.hidden)
			}
			.padding(.horizontal, 8)
			.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
			.presentationDetents([.medium])
		}
    }
	
	var header: some View {
		HStack(spacing: 4) {
			Image(systemName: "chevron.left")
				.onTapGesture {
					dismiss()
				}
			
			Text(title)
				.font(.karlRegular(size: 14))
				.frame(maxWidth: .infinity, alignment: .leading)
			Button {
				// Action
			} label: {
				// TODO: Handle the logic
				Text("Select All")
					.fontWeight(.semibold)
					.padding(.horizontal, 12)
					.padding(.vertical, 8)
					.background(.skyBlue)
					.clipShape(.capsule)
			}
			.foregroundStyle(.white)
		}
		.frame(minHeight: 56)
		.overlay(alignment: .bottom) {
			Divider()
		}
	}
	
	@ViewBuilder
	private func TaskItemView(task: TaskItem) -> some View {
		VStack {
			if let images = task.images {
				Rectangle()
					.frame(height: 240)
					.overlay {
						Image(images.first ?? "")
							.resizable()
							.scaledToFill()
					}
					.overlay(alignment: .bottomLeading) {
						HStack {
							ForEach(images, id: \.self) { _ in
								Circle()
									.fill(.white)
									.frame(width: 8, height: 8)
									.onTapGesture {
										// TODO: Handle changing images in a carousel
									}
							}
						}
						.padding()
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
//							.background(.red)
					}
					if let benefits = task.benefits {
						Text(benefits.joined(separator: ", "))
							.font(.system(size: 14))
							.foregroundStyle(.deepBlue)
					}
				}
				.frame(maxWidth: .infinity, alignment: .leading)
				// TODO: Fix the icon fonts - use custom icon
				Image(systemName: "plus")
					.font(.title3)
					.fontWeight(.medium)
					.frame(width: 38, height: 38)
					.padding(2)
					.background(Color.skyBlue.opacity(0.15))
					.clipShape(.circle)
			}
			.padding()
		}
		.padding(.bottom, 4)
		.background(.white)
		.cornerRadius(20)
		// TODO: Fix the card Shadow
		.shadow(color: .yellow, radius: 4)
	}
}

struct RoundedCorners: Shape {
	var radius: CGSize = .zero
	var corners: UIRectCorner = .allCorners
	
	func path(in rect: CGRect) -> Path {
		let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: radius)
		return Path(path.cgPath)
	}
}

extension View {
	func cornerRadius(_ radius: CGSize, corners: UIRectCorner = .allCorners) -> some View {
		clipShape(RoundedCorners(radius: radius, corners: corners))
	}
}

#Preview {
    TaskDetails(title: "DETAILED MORNING ROUTINE TASKS")
}
