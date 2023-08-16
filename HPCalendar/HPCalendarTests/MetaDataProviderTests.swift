//
//  HPCalendarTests.swift
//  HPCalendarTests
//
//  Created by Hsueh Peng Tseng on 2023/8/16.
//

import XCTest
import HPCalendar

final class MetaDataProviderTests: XCTestCase {
	
	func test_getFirstDateOfMonth_generateFirstDateOfMonthByGivenDate() {
		let (sut, _) = makeSut()
		
		(1...12).forEach { month in
			let index = month - 1
			let firstDateOfTestingMonth = firstDateOfMonthStubs()[index]
			let firstDateOfMonth = sut.getFirstDateOfMonth(for: testingDates[index])
					
			XCTAssertEqual(firstDateOfMonth, firstDateOfTestingMonth)
		}
	}
	
	func test_numbersOfDaysInMonth_getNumbersOfDaysInGivenDate() {
		let (sut, _) = makeSut()
		
		(1...12).forEach { month in
			let index = month - 1
			let daysOfTestingMonth = daysOfMonthStubs()[index]
			let daysOfMonth = sut.numbersOfDaysInMonth(for: testingDates[index])
						
			XCTAssertEqual(daysOfMonth, daysOfTestingMonth)
		}
	}
	
	func test_firstDateOffSet_getFirstDateWeekDayOffset() {
		let (sut, _) = makeSut()
		
		(1...12).forEach { month in
			let index = month - 1
			let dateOffsetTestingMonth = firstDateOffSetStubs()[index]
			let dateOffset = sut.firstDateOffSet(for: testingDates[index])
					
			XCTAssertEqual(dateOffset, dateOffsetTestingMonth)
		}
	}
	
	func test_nextMonthOffSet_getNextMonthWeekDayOffset() {
		let (sut, _) = makeSut()
		
		(1...12).forEach { month in
			let index = month - 1
			let nextMonthDateOffsetTestingMonth = nextMonthWeekDayOffSetStubs()[index]
			let nextMonthDateOffset = sut.nextMonthWeekDayOffSet(for: testingDates[index])
					
			XCTAssertEqual(nextMonthDateOffset, nextMonthDateOffsetTestingMonth)
		}
	}
	
	// MARK: - Helpers
	
	private func makeSut() -> (MetaDataProvider, Calendar) {
		var calendar = Calendar(identifier: .gregorian)
		calendar.timeZone = .gmt
		let sut = MetaDataProvider(calendar: calendar)
		return (sut, calendar)
	}
	
	private let testingDates = [Date(timeIntervalSince1970: 1673827200), // 2023/01/16
								Date(timeIntervalSince1970: 1676505600), // 2023/02/16
								Date(timeIntervalSince1970: 1678924800), // 2023/03/16
								Date(timeIntervalSince1970: 1681603200), // 2023/04/16
								Date(timeIntervalSince1970: 1684195200), // 2023/05/16
								Date(timeIntervalSince1970: 1686873600), // 2023/06/16
								Date(timeIntervalSince1970: 1689465600), // 2023/07/16
								Date(timeIntervalSince1970: 1692144000), // 2023/08/16
								Date(timeIntervalSince1970: 1694822400), // 2023/09/16
								Date(timeIntervalSince1970: 1697414400), // 2023/10/16
								Date(timeIntervalSince1970: 1700092800), // 2023/11/16
								Date(timeIntervalSince1970: 1702684800)  // 2023/12/16
								
	]
	
	private func firstDateOfMonthStubs() -> [Date] {
		return [Date(timeIntervalSince1970: 1672531200), // 2023/01/01 00:00
				Date(timeIntervalSince1970: 1675209600), // 2023/02/01 00:00
				Date(timeIntervalSince1970: 1677628800), // 2023/03/01 00:00
				Date(timeIntervalSince1970: 1680307200), // 2023/04/01 00:00
				Date(timeIntervalSince1970: 1682899200), // 2023/05/01 00:00
				Date(timeIntervalSince1970: 1685577600), // 2023/06/01 00:00
				Date(timeIntervalSince1970: 1688169600), // 2023/07/01 00:00
				Date(timeIntervalSince1970: 1690848000), // 2023/08/01 00:00
				Date(timeIntervalSince1970: 1693526400), // 2023/09/01 00:00
				Date(timeIntervalSince1970: 1696118400), // 2023/10/01 00:00
				Date(timeIntervalSince1970: 1698796800), // 2023/11/01 00:00
				Date(timeIntervalSince1970: 1701388800)  // 2023/12/01 00:00
		]
	}
	
	private func daysOfMonthStubs() -> [Int] {
		return [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30 ,31]
	}
	
	private func firstDateOffSetStubs() -> [Int] {
		return [1, 4, 4, 7, 2, 5, 7, 3, 6, 1, 4, 6]
	}
	
	private func nextMonthWeekDayOffSetStubs() -> [Int] {
		return [4, 4, 1, 6, 3, 1, 5, 2, 0, 4, 2, 6]
	}

}
