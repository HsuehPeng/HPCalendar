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
	
	func numbersOfDaysInMonth(for date: Date) -> Int {
		guard let numbersOfDaysRange = calendar.range(of: .day, in: .month, for: date) else { return 0 }
		return numbersOfDaysRange.count
	}
	
	func firstDateOffSet(for date: Date) -> Int {
		let firstDateOfMonth = getFirstDateOfMonth(for: date)
		return calendar.component(.weekday, from: firstDateOfMonth)
	}
	
}

final class MetaDataProviderTests: XCTestCase {
	
	func test_getFirstDateOfMonth_generateFirstDateOfMonthByGivenDate() {
		let (sut, _) = makeSut()

		let firstDateOfTestingMonth = firstDateOfMonthStub()
		let firstDateOfMonth = sut.getFirstDateOfMonth(for: testingDate)
				
		XCTAssertEqual(firstDateOfMonth, firstDateOfTestingMonth)
	}
	
	func test_numbersOfDaysInMonth_getNumbersOfDaysInGivenDate() {
		let (sut, _) = makeSut()

		let daysOfTestingMonth = daysOfMonthStub()
		let daysOfMonth = sut.numbersOfDaysInMonth(for: testingDate)
				
		XCTAssertEqual(daysOfMonth, daysOfTestingMonth)
	}
	
	func test_firstDateOffSet_getFirstDateWeekDayForGivenDate() {
		let (sut, _) = makeSut()

		let dateOffsetTestingMonth = firstDateOffSet()
		let dateOffset = sut.firstDateOffSet(for: testingDate)
				
		XCTAssertEqual(dateOffset, dateOffsetTestingMonth)
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
	
	private func daysOfMonthStub() -> Int {
		return 31
	}
	
	private func firstDateOffSet() -> Int {
		return 3
	}

}
