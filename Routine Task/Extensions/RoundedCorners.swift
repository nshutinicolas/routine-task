//
//  RoundedCorners.swift
//  Routine Task
//
//  Created by Musoni nshuti Nicolas on 20/12/2024.
//

import SwiftUI

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
