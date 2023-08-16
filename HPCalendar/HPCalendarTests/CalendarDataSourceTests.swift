//
//  CalendarDataSource.swift
//  HPCalendarTests
//
//  Created by Hsueh Peng Tseng on 2023/8/16.
//

import XCTest
import HPCalendar

final class CalendarDataSourceTests: XCTestCase {
	
	func test_generateDaysInMonth_getDaysCountByGivenMonth() {
		let sut = makeSut()
		
		let currentDate = Date()
		let days = sut.generateDaysInMonth(for: currentDate)
		
		XCTAssertEqual(days.count, numbersOfCalendarCell)
	}
	
	// MARK: - Helpers
	
	private func makeSut() -> CalendarDataSource {
		var calendar = Calendar(identifier: .gregorian)
		calendar.timeZone = .gmt
		let sut = CalendarDataSource(metaDataProvider: MetaDataProvider(calendar: calendar), calendar: calendar)
		
		return sut
	}
	
	private let numbersOfCalendarCell = 35
	
}
