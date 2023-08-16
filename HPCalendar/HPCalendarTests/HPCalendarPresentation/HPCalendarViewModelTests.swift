//
//  HPCalendarViewModel.swift
//  HPCalendarTests
//
//  Created by Hsueh Peng Tseng on 2023/8/16.
//

import XCTest
@testable import HPCalendar

class HPCalendarViewModel {
	private let dataSource: CalendarDataSource
	
	var baseDate: Date {
		didSet {
			days = dataSource.generateDaysInMonth(for: baseDate)
		}
	}
	
	var days: [HPDay]
	
	init(dataSource: CalendarDataSource, baseDate: Date = Date()) {
		self.dataSource = dataSource
		self.baseDate = baseDate
		self.days = dataSource.generateDaysInMonth(for: baseDate)
	}
}

final class HPCalendarViewModelTests: XCTestCase {
	
	func test_init_setBaseDate() {
		let currentDate = Date()
		let (sut, _) = makeSut(baseDate: currentDate)
		
		XCTAssertEqual(sut.baseDate, currentDate)
	}
	
	func test_didSetBaseDate_updateDaysWhenSetBaseDate() {
		let (sut, dataSource) = makeSut()
		
		XCTAssertEqual(dataSource.setDaysCount, 1)
		
		sut.baseDate = Date()
		
		XCTAssertEqual(dataSource.setDaysCount, 2)
	}
	
	// MARK: - Helpers
	
	private func makeSut(baseDate: Date = Date()) -> (HPCalendarViewModel, CalendarDataSourceSpy) {
		var calendar = Calendar(identifier: .gregorian)
		calendar.timeZone = .gmt
		let dataSource = CalendarDataSourceSpy(calendar: calendar)
		let sut = HPCalendarViewModel(dataSource: dataSource, baseDate: baseDate)
		
		return (sut, dataSource)
	}
	
	class CalendarDataSourceSpy: CalendarDataSource {
		var setDaysCount: Int = 0
		
		override func generateDaysInMonth(for date: Date) -> [HPDay] {
			setDaysCount += 1
			return []
		}
	}
}
