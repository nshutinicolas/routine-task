//
//  UINavigationController+Extension.swift
//  Routine Task
//
//  Created by Musoni nshuti Nicolas on 20/12/2024.
//

import UIKit

/// Hide navigation bar for all navigation stacks
extension UINavigationController {
	open override func viewWillLayoutSubviews() {
		super.viewWillLayoutSubviews()
		navigationBar.isHidden = true
	}
}
