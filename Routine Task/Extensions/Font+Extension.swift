//
//  Font+Extension.swift
//  Routine Task
//
//  Created by Musoni nshuti Nicolas on 20/12/2024.
//

import Foundation
import SwiftUI

enum CustomFont {
	static let cardoBold = "Cardo-Bold"
	static let cardoItalic = "Cardo-Italic"
	static let cardoRegular = "Cardo-Regular"
	static let karlBold = "Karl-Bold"
	static let karlRegular = "Karl-Regular"
}

extension Font {
	static func karlBold(size: CGFloat, relativeTo: TextStyle = .body) -> Font {
		Font.custom(CustomFont.karlBold, size: size, relativeTo: relativeTo)
	}
	
	static func karlRegular(size: CGFloat, relativeTo: TextStyle = .body) -> Font {
		Font.custom(CustomFont.karlRegular, size: size, relativeTo: relativeTo)
	}
	
	static func cardoBold(size: CGFloat, relativeTo: TextStyle = .body) -> Font {
		Font.custom(CustomFont.cardoBold, size: size, relativeTo: relativeTo)
	}
	
	static func cardoItalic(size: CGFloat, relativeTo: TextStyle = .body) -> Font {
		Font.custom(CustomFont.cardoItalic, size: size, relativeTo: relativeTo)
	}
	
	static func cardoRegular(size: CGFloat, relativeTo: TextStyle = .body) -> Font {
		Font.custom(CustomFont.cardoRegular, size: size, relativeTo: relativeTo)
	}
}
