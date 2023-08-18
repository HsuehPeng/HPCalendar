//
//  HPCalendarViewModel.swift
//  HPCalendarTests
//
//  Created by Hsueh Peng Tseng on 2023/8/16.
//

import XCTest
@testable import HPCalendar

final class HPSingleCalendarViewModelTests: XCTestCase {
	
	func test_init_setBaseDate() {
		let currentDate = Date()
		let (sut, _) = makeSut(baseDate: currentDate)
		
		XCTAssertEqual(sut.baseDate, currentDate)
	}
	
	func test_init_renderCorrectHeaderDate() {
		let currentDate = Date()
		let (sut, _) = makeSut(baseDate: currentDate)
		let dateFormatter = makeDateFormatterTestHelper()

		XCTAssertEqual(sut.headerText, dateFormatter.string(from: currentDate))
	}
	
	func test_generateHPDays_dayLoaderGenerateHPDaysCallCount() {
		let (sut, dayLoader) = makeSut()
		XCTAssertEqual(dayLoader.generateDaysCount, 1)
		
		sut.baseDate = Date()
		XCTAssertEqual(dayLoader.generateDaysCount, 2)
		
		sut.setNextBaseDate()
		XCTAssertEqual(dayLoader.generateDaysCount, 3)
		
		sut.setPreviousBaseDate()
		XCTAssertEqual(dayLoader.generateDaysCount, 4)
	}
	
	func test_setNextBaseDate_baseDateChangeToNextBaseDate() {
		let currentDate = Date()
		let (sut, _) = makeSut(baseDate: currentDate)
		
		let nextBaseDate = setNextBaseDate(for: currentDate)
		sut.setNextBaseDate()
		
		XCTAssertEqual(sut.baseDate, nextBaseDate)
	}
	
	func test_setPreviousBaseDate_baseDateChangeToPreviousBaseDate() {
		let currentDate = Date()
		let (sut, _) = makeSut(baseDate: currentDate)
		
		let preBaseDate = setPreviousBaseDate(for: currentDate)
		sut.setPreviousBaseDate()
		
		XCTAssertEqual(sut.baseDate, preBaseDate)
	}
	
	// MARK: - Helpers
	
	private func makeSut(baseDate: Date = Date()) -> (HPSingleCalendarViewModel, HPDayLoaderSpy) {
		let daysLoader = HPDayLoaderSpy()
		let calendar = makeCalendarTestHelper()
		let calendarManager = HPCalendarManager(calendar: calendar)
		let sut = HPSingleCalendarViewModel(baseDate: baseDate, dayLoader: daysLoader, calendarManager: calendarManager, headerTextFormate: headerDateFormateHelper)

		return (sut, daysLoader)
	}
	
	private func makeCalendarTestHelper() -> Calendar {
		var calendar = Calendar(identifier: .gregorian)
		calendar.timeZone = .gmt
		return calendar
	}
	
	private func makeDateFormatterTestHelper() -> DateFormatter {
		let formatter = DateFormatter()
		formatter.calendar = makeCalendarTestHelper()
		formatter.dateFormat = headerDateFormateHelper
		return formatter
	}
		
	private func setNextBaseDate(for baseDate: Date) -> Date {
		let calendar = makeCalendarTestHelper()
		let nextBaseDate = calendar.date(byAdding: .month, value: 1, to: baseDate)
		return nextBaseDate!
	}
	
	private func setPreviousBaseDate(for baseDate: Date) -> Date {
		let calendar = makeCalendarTestHelper()
		let previousBaseDate = calendar.date(byAdding: .month, value: -1, to: baseDate)
		return previousBaseDate!
	}
	
	private var headerDateFormateHelper: String {
		return "MMMM yyyy"
	}
	
	class HPDayLoaderSpy: HPDayLoader {
		var generateDaysCount = 0
		
		func generateHPDaysInMonth(for date: Date) -> [HPDay] {
			generateDaysCount += 1
			return []
		}
	}

}
