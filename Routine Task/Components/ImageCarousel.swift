//
//  ImageCarousel.swift
//  Routine Task
//
//  Created by Musoni nshuti Nicolas on 20/12/2024.
//

import SwiftUI

struct ImageCarousel: View {
	let images: [String]
	@State var selectedImage = ""
	
	init(images: [String]) {
		self.images = images
	}
	
	var body: some View {
		VStack {
			TabView(selection: $selectedImage) {
				ForEach(images, id: \.self) { image in
					Image(image)
						.resizable()
						.scaledToFill()
				}
			}
			.tabViewStyle(.page(indexDisplayMode: .never))
		}
		.overlay(alignment: .bottomLeading) {
			HStack {
				ForEach(images, id: \.self) { imageName in
					Circle()
						.fill(selectedImage == imageName ? .skyBlue : .white)
						.frame(width: 8, height: 8)
						.onTapGesture {
							selectedImage = imageName
						}
				}
			}
			.padding()
		}
		.onAppear {
			selectedImage = images.first ?? ""
		}
	}
}

#Preview {
	ImageCarousel(images: ["image-1", "image-2", "image-3"])
		.frame(height: 300)
}
