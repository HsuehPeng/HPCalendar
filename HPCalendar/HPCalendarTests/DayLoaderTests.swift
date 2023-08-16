//
//  HPCalendarTests.swift
//  HPCalendarTests
//
//  Created by Hsueh Peng Tseng on 2023/8/16.
//

import XCTest

class DayLoader {
	let calendar: Calendar
	
	init(calendar: Calendar) {
		self.calendar = calendar
	}
	
	func getFirstDateOfMonth(for date: Date) -> Date {
		let components = calendar.dateComponents([.year, .month], from: date)
		return calendar.date(from: components) ?? date
	}
}

final class DayLoaderTests: XCTestCase {
	
	func test_getFirstDateOfMonth_generateFirstDateOfMonthByGivenDate() {
		let (sut, calendar) = makeSut()
		
		let today = Date()
		let firstDateOfCurrentMonth = getFirstDateOfMonth(for: today, calendar: calendar)
		let firstDateOfMonth = sut.getFirstDateOfMonth(for: today)
				
		XCTAssertEqual(firstDateOfMonth, firstDateOfCurrentMonth)
	}
	
	// MARK: - Helpers
	
	private func makeSut() -> (DayLoader, Calendar) {
		var calendar = Calendar(identifier: .gregorian)
		calendar.timeZone = .gmt
		let sut = DayLoader(calendar: calendar)
		return (sut, calendar)
	}
	
	private func getFirstDateOfMonth(for date: Date, calendar: Calendar) -> Date {
		let components = calendar.dateComponents([.year, .month], from: date)
		return calendar.date(from: components) ?? date
	}

}
