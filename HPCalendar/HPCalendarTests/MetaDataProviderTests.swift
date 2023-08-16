//
//  HPCalendarTests.swift
//  HPCalendarTests
//
//  Created by Hsueh Peng Tseng on 2023/8/16.
//

import XCTest

class MetaDataProvider {
	let calendar: Calendar
	
	init(calendar: Calendar) {
		self.calendar = calendar
	}
	
	func getFirstDateOfMonth(for date: Date) -> Date {
		let components = calendar.dateComponents([.year, .month], from: date)
		return calendar.date(from: components) ?? date
	}
}

final class MetaDataProviderTests: XCTestCase {
	
	func test_getFirstDateOfMonth_generateFirstDateOfMonthByGivenDate() {
		let (sut, _) = makeSut()

		let firstDateOfTestingMonth = firstDateOfMonthStub()
		let firstDateOfMonth = sut.getFirstDateOfMonth(for: testingDate)
				
		XCTAssertEqual(firstDateOfMonth, firstDateOfTestingMonth)
	}
	
	// MARK: - Helpers
	
	private func makeSut() -> (MetaDataProvider, Calendar) {
		var calendar = Calendar(identifier: .gregorian)
		calendar.timeZone = .gmt
		let sut = MetaDataProvider(calendar: calendar)
		return (sut, calendar)
	}
	
	private let testingDate = Date(timeIntervalSince1970: 1692144000)
		
	private func firstDateOfMonthStub() -> Date {
		return Date(timeIntervalSince1970: 1690848000)
	}

}
