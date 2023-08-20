//
//  HPCalendarView+TestHelpers.swift
//  HPCalendarTests
//
//  Created by Hsueh Peng Tseng on 2023/8/17.
//

import UIKit
@testable import HPCalendar

extension HPSingleSelectionCalendarView {
	func numbersOfCalendarCell() -> Int {
		return collectionView.numberOfItems(inSection: calendarSection)
	}
	
	func cellForItemAt(at item: Int) -> UICollectionViewCell? {
		let ds = collectionView.dataSource
		let index = IndexPath(item: item, section: calendarSection)
		return ds?.collectionView(collectionView, cellForItemAt: index)
	}
	
	func calendarCellDateNumber(at item: Int) -> String {
		guard let cell = cellForItemAt(at: item) as? HPCalendarCell else { return "A" }
		return cell.dateLabel.text ?? "A"
	}
	
	func calendarCellDateLabelTextColor(at item: Int) -> UIColor {
		guard let cell = cellForItemAt(at: item) as? HPCalendarCell else { return .clear }
		return cell.dateLabel.textColor ?? .clear
	}
	
	func simnulateHeaderViewTapNextButton() {
		headerView.nextButton.simulateTap()
	}
	
	func simnulateHeaderViewTapPreviousButton() {
		headerView.previousButton.simulateTap()
	}
	
	private var calendarSection: Int {
		return 0
	}
}
