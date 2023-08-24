//
//  WeekDayHStackView.swift
//  HPCalendar
//
//  Created by Hsueh Peng Tseng on 2023/8/24.
//

import UIKit

class WeekDayHStackView: UIStackView {
	convenience init() {
		self.init(frame: .zero)
		self.axis = .horizontal
		self.spacing = 0
		self.distribution = .fillEqually
		self.alignment = .fill
		self.translatesAutoresizingMaskIntoConstraints = false
		self.addArrangedSubviews(subviews: weekDaysLabel)
	}
	
	private lazy var weekDaysLabel: [UILabel] = {
		let weekDaysString = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
		var labels = [UILabel]()
		
		for day in weekDaysString {
			labels.append(makeWeekDayLabel(weekDay: day))
		}
		
		return labels
	}()
	
	private func makeWeekDayLabel(weekDay: String) -> UILabel {
		let label = UILabel()
		label.text = weekDay
		label.font = UIFont.systemFont(ofSize: 13, weight: .medium)
		label.textAlignment = .center
		label.textColor = HPCalendarCellUIConfiguration.withinMonthTextColor.toUIColor()
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}
}
