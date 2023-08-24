//
//  HPCalendarView+TestHelpers.swift
//  HPCalendarTests
//
//  Created by Hsueh Peng Tseng on 2023/8/17.
//

import UIKit
@testable import HPCalendar

extension HPCalendarView {
	func numbersOfCalendarCell() -> Int {
		return collectionView.numberOfItems(inSection: calendarSection)
	}
	
	func cellForItemAt(at item: Int) -> HPCalendarCell {
		let ds = collectionView.dataSource
		let index = IndexPath(item: item, section: calendarSection)
		return ds?.collectionView(collectionView, cellForItemAt: index) as! HPCalendarCell
	}
	
	func calendarCellDateNumber(at item: Int) -> String {
		let cell = cellForItemAt(at: item)
		return cell.dateLabel.text ?? "A"
	}
	
	func calendarCellDateLabelTextColor(at item: Int) -> UIColor {
		let cell = cellForItemAt(at: item)
		return cell.dateLabel.textColor ?? .clear
	}
	
	func simnulateHeaderViewTapNextButton() {
		headerView.nextButton.simulateTap()
	}
	
	func simnulateHeaderViewTapPreviousButton() {
		headerView.previousButton.simulateTap()
	}
	
	func simulateSelectHpCalendarCell(at item: Int) {
		let delegate = collectionView.delegate
		let index = IndexPath(item: item, section: calendarSection)
		delegate?.collectionView?(collectionView, didSelectItemAt: index)
	}
	
	func calendarCellSelectionViewColor(at item: Int) -> UIColor {
		let cell = cellForItemAt(at: item)
		return cell.selectionView.backgroundColor ?? .brown
	}
	
	private var calendarSection: Int {
		return 0
	}
}
