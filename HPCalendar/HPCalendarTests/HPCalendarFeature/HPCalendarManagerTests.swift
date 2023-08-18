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
		
		let addedDate = sut.addTimeUnit(with: timeUnit, to: currentDate)
		let testedDate = addTimeUnit(for: currentDate, by: timeUnit)
		
		XCTAssertEqual(addedDate, testedDate)
	}
	
	func test_minusTimeUnit_minusCorrectUnitToDate() {
		let currentDate = Date()
		let sut = makeSut()
		
		let minusedDate = sut.minusTimeUnit(with: timeUnit, to: currentDate)
		let testedDate = minusTimeUnit(for: currentDate, by: timeUnit)
		
		XCTAssertEqual(minusedDate, testedDate)
	}
	
	func test_transformToFormattedDate_deliversCorrectFormattedDateString() {
		let currentDate = Date()
		let sut = makeSut()
		
		let transformedDateString = sut.transformToFormattedDate(from: currentDate, by: dateFormate)
		let testedDateString = formattedDateString(from: currentDate, by: dateFormate)
		
		XCTAssertEqual(transformedDateString, testedDateString)
	}
	
	// MARK: - Helpers
	
	private func makeSut() -> HPCalendarManager {
		let manager = HPCalendarManager(calendar: makeTestCalendar())
		return manager
	}
	
	private func addTimeUnit(for baseDate: Date, by unit: Calendar.Component) -> Date {
		let calendar = makeTestCalendar()
		let nextBaseDate = calendar.date(byAdding: unit, value: 1, to: baseDate)
		return nextBaseDate!
	}

	private func minusTimeUnit(for baseDate: Date, by unit: Calendar.Component) -> Date {
		let calendar = makeTestCalendar()
		let previousBaseDate = calendar.date(byAdding: unit, value: -1, to: baseDate)
		return previousBaseDate!
	}
	
	private func formattedDateString(from date: Date, by formate: String) -> String {
		let dateFormmater = DateFormatter()
		dateFormmater.dateFormat = formate
		dateFormmater.calendar = makeTestCalendar()
		return dateFormmater.string(from: date)
	}
	
	private var dateFormate: String {
		return "MM"
	}
	
	private let timeUnit: Calendar.Component = .month
}

