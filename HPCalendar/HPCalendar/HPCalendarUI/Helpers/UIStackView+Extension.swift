//
//  UIStackView_Extension.swift
//  HPCalendar
//
//  Created by Hsueh Peng Tseng on 2023/8/21.
//

import UIKit

extension UIStackView {
	func addArrangedSubviews(subviews: [UIView]) {
		subviews.forEach { subview in
			addArrangedSubview(subview)
		}
	}
}
