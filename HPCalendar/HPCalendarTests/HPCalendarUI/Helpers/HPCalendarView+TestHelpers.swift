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
	
	func cellForItemAt(at item: Int) -> UICollectionViewCell? {
		let ds = collectionView.dataSource
		let index = IndexPath(item: item, section: calendarSection)
		return ds?.collectionView(collectionView, cellForItemAt: index)
	}
	
	func calendarCellDateNumber(at item: Int) -> String {
		guard let cell = cellForItemAt(at: item) as? HPCalendarCell else { return "A" }
		return cell.dateLabel.text ?? "A"
	}
	
	private var calendarSection: Int {
		return 0
	}
}
