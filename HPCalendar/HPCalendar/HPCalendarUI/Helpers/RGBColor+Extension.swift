//
//  UIColor+Extension.swift
//  HPCalendar
//
//  Created by Hsueh Peng Tseng on 2023/8/24.
//

import UIKit

extension RGBColor {
	func toUIColor() -> UIColor {
		return UIColor(red: CGFloat(red), green: CGFloat(green), blue: CGFloat(blue), alpha: 1)
	}
}
