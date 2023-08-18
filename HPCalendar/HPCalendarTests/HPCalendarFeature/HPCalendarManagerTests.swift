//
//  HPCalendarManagerTests.swift
//  HPCalendarTests
//
//  Created by Hsueh Peng Tseng on 2023/8/18.
//

import XCTest
@testable import HPCalendar

final class HPCalendarManagerTests: XCTestCase {
	
	func test_addTimeUnit_addCorrectUnitToDate() {
		let currentDate = Date()
		let sut = makeSut()
		
		let addedDate = sut.addTimeUnit(with: .month, to: currentDate)
		let testedDate = addTimeUnit(for: currentDate, by: .month)
		
		XCTAssertEqual(addedDate, testedDate)
	}
	
	func test_minusTimeUnit_minusCorrectUnitToDate() {
		let currentDate = Date()
		let sut = makeSut()
		
		let minusedDate = sut.minusTimeUnit(with: .month, to: currentDate)
		let testedDate = minusTimeUnit(for: currentDate, by: .month)
		
		XCTAssertEqual(minusedDate, testedDate)
	}
	
	func test_transformToFormattedDate_deliversCorrectFormattedDateString() {
		let currentDate = Date()
		let sut = makeSut()
		
		let transformedDateString = sut.transformToFormattedDate(from: currentDate, by: dateFormateHelper)
		let testedDateString = formattedDateString(from: currentDate, by: dateFormateHelper)
		
		XCTAssertEqual(transformedDateString, testedDateString)
	}
	
	// MARK: - Helpers
	
	private func makeSut() -> HPCalendarManager {
		let manager = HPCalendarManager(calendar: makeCalendarTestHelper())
		return manager
	}
	
	private func makeCalendarTestHelper() -> Calendar {
		var calendar = Calendar(identifier: .gregorian)
		calendar.timeZone = .gmt
		return calendar
	}
	
	private func addTimeUnit(for baseDate: Date, by unit: Calendar.Component) -> Date {
		let calendar = makeCalendarTestHelper()
		let nextBaseDate = calendar.date(byAdding: unit, value: 1, to: baseDate)
		return nextBaseDate!
	}

	private func minusTimeUnit(for baseDate: Date, by unit: Calendar.Component) -> Date {
		let calendar = makeCalendarTestHelper()
		let previousBaseDate = calendar.date(byAdding: unit, value: -1, to: baseDate)
		return previousBaseDate!
	}
	
	private func formattedDateString(from date: Date, by formate: String) -> String {
		let dateFormmater = DateFormatter()
		dateFormmater.dateFormat = formate
		dateFormmater.calendar = makeCalendarTestHelper()
		return dateFormmater.string(from: date)
	}
	
	private var dateFormateHelper: String {
		return "MM"
	}
}


