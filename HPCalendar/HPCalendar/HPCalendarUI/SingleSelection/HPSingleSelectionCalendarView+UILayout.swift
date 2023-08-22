//
//  HPSingleSelectionCalendarView+UILayout.swift
//  HPCalendar
//
//  Created by Hsueh Peng Tseng on 2023/8/21.
//

import UIKit

extension HPSingleSelectionCalendarView {
	func setupUI() {
		self.addSubview(headerView)
		self.addSubview(weekDayHStack)
		self.addSubview(collectionView)
		
		NSLayoutConstraint.activate([
			headerView.topAnchor.constraint(equalTo: self.topAnchor),
			headerView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
			headerView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
			headerView.heightAnchor.constraint(equalToConstant: 40)
		])
		
		weekDayHStack.addArrangedSubviews(subviews: weekDaysLabel)
		NSLayoutConstraint.activate([
			weekDayHStack.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 12),
			weekDayHStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
			weekDayHStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
			weekDayHStack.heightAnchor.constraint(equalToConstant: 34)
		])
		
		NSLayoutConstraint.activate([
			collectionView.topAnchor.constraint(equalTo: weekDayHStack.bottomAnchor),
			collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
			collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
			collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
		])
	}
	
	func makeWeekDayLabel(weekDay: String) -> UILabel {
		let label = UILabel()
		label.text = weekDay
		label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
		label.textAlignment = .center
		label.textColor = HPSingleSelectionCalendarUIConfiguration.withinMonthTextColor
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}
}
