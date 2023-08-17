//
//  HPCalendarViewModel.swift
//  HPCalendarTests
//
//  Created by Hsueh Peng Tseng on 2023/8/16.
//

import XCTest
@testable import HPCalendar

final class HPCalendarViewModelTests: XCTestCase {
	
	func test_init_setBaseDate() {
		let currentDate = Date()
		let sut = makeSut(baseDate: currentDate)
		
		XCTAssertEqual(sut.baseDate, currentDate)
	}
	
	func test_init_renderCorrectHeaderDate() {
		let currentDate = Date()
		let sut = makeSut(baseDate: currentDate)
		let dateFormatter = makeDateFormatterTestHelper(formate: dateFormateTestHelper)

		XCTAssertEqual(sut.headerText, dateFormatter.string(from: currentDate))
	}
	
	func test_setNextBaseDate_baseDateChangeToNextBaseDate() {
		let currentDate = Date()
		let sut = makeSut(baseDate: currentDate)
		
		let nextBaseDate = setNextBaseDate(for: currentDate)
		sut.setNextBaseDate()
		
		XCTAssertEqual(sut.baseDate, nextBaseDate)
	}
	
	// MARK: - Helpers
	
	private func makeSut(baseDate: Date = Date()) -> HPCalendarViewModel {
		let calendar = makeCalendarTestHelper()
		let dateFormater = makeDateFormatterTestHelper(formate: dateFormateTestHelper)
		let sut = HPSingleCalendarViewModel(baseDate: baseDate, dateFormater: dateFormater, calendar: calendar)
		
		return sut
	}
	
	private func makeCalendarTestHelper() -> Calendar {
		var calendar = Calendar(identifier: .gregorian)
		calendar.timeZone = .gmt
		return calendar
	}
	
	private func makeDateFormatterTestHelper(formate: String) -> DateFormatter {
		let dateFormater = DateFormatter()
		dateFormater.calendar = makeCalendarTestHelper()
		dateFormater.dateFormat = formate
		return dateFormater
	}
	
	private func setNextBaseDate(for baseDate: Date) -> Date {
		let calendar = makeCalendarTestHelper()
		let nextBaseDate = calendar.date(byAdding: .month, value: 1, to: baseDate)
		return nextBaseDate!
	}
	
	private var dateFormateTestHelper: String {
		return "MMMM yyyy"
	}

}
