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
		let (sut, _) = makeSut(baseDate: currentDate)
		
		XCTAssertEqual(sut.baseDate, currentDate)
	}
	
	func test_init_renderCorrectHeaderDate() {
		let currentDate = Date()
		let (sut, _) = makeSut(baseDate: currentDate)
		let dateFormatter = makeDateFormatterTestHelper(formate: dateFormateTestHelper)

		XCTAssertEqual(sut.headerText, dateFormatter.string(from: currentDate))
	}
	
	func test_didSetBaseDate_updateDaysWhenSetBaseDate() {
		var (sut, dataSource) = makeSut()
		
		XCTAssertEqual(dataSource.setDaysCount, 1)
		
		sut.baseDate = Date()
		
		XCTAssertEqual(dataSource.setDaysCount, 2)
	}
	
	// MARK: - Helpers
	
	private func makeSut(baseDate: Date = Date()) -> (HPCalendarViewModel, CalendarDataSourceSpy) {
		let calendar = makeCalendarTestHelper()
		let dataSource = CalendarDataSourceSpy(calendar: calendar)
		let dateFormater = makeDateFormatterTestHelper(formate: dateFormateTestHelper)
		let sut = HPSingleCalendarViewModel(dataSource: dataSource, baseDate: baseDate, dateFormater: dateFormater, calendar: calendar)
		
		return (sut, dataSource)
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
	
	private var dateFormateTestHelper: String {
		return "MMMM yyyy"
	}
	
	class CalendarDataSourceSpy: CalendarDataSource {
		var setDaysCount: Int = 0
		
		override func generateDaysInMonth(for date: Date) -> [HPDay] {
			setDaysCount += 1
			return []
		}
	}
}
