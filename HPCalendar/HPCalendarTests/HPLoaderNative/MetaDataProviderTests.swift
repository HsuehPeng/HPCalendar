//
//  HPCalendarTests.swift
//  HPCalendarTests
//
//  Created by Hsueh Peng Tseng on 2023/8/16.
//

import XCTest
@testable import HPCalendar

final class MetaDataProviderTests: XCTestCase {
	
	func test_getFirstDateOfMonth_generateFirstDateOfMonthByGivenDate() {
		let sut = makeSut()

		(1...12).forEach { month in
			let index = month - 1
			let firstDateOfTestingMonth = firstDateOfMonthStubs()[index]
			let firstDateOfMonth = sut.getFirstDateOfMonth(for: testingDates[index])

			XCTAssertEqual(firstDateOfMonth, firstDateOfTestingMonth)
		}
	}
	
	func test_getLastDateOfMonth_generateLastDateOfMonthByGivenDate() {
		let sut = makeSut()

		(1...12).forEach { month in
			let index = month - 1
			let lastDateOfTestingMonth = lastDateOfMonthStubs()[index]
			let lastDateOfMonth = sut.getLastDateOfMonth(for: testingDates[index])

			XCTAssertEqual(lastDateOfMonth, lastDateOfTestingMonth)
		}
	}
	
	func test_numbersOfDaysInMonth_getNumbersOfDaysInGivenDate() {
		let sut = makeSut()

		(1...12).forEach { month in
			let index = month - 1
			let daysOfTestingMonth = daysOfMonthStubs()[index]
			let daysOfMonth = sut.numbersOfDaysInMonth(for: testingDates[index])

			XCTAssertEqual(daysOfMonth, daysOfTestingMonth)
		}
	}
	
	func test_firstDateOffSet_getFirstDateWeekDayOffset() {
		let sut = makeSut()

		(1...12).forEach { month in
			let index = month - 1
			let dateOffsetTestingMonth = firstDateOffSetStubs()[index]
			let dateOffset = sut.firstDateOffSet(for: testingDates[index])

			XCTAssertEqual(dateOffset, dateOffsetTestingMonth)
		}
	}
	
	// MARK: - Helpers
	
	private func makeSut() -> MetaDataProvider {
		let calendar = makeTestCalendar()
		let sut = MetaDataProvider(calendar: calendar)
		return sut
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
	
	private func lastDateOfMonthStubs() -> [Date] {
		return [Date(timeIntervalSince1970: 1675123200), // 2023/01/31 00:00
				Date(timeIntervalSince1970: 1677542400), // 2023/02/28 00:00
				Date(timeIntervalSince1970: 1680220800), // 2023/03/31 00:00
				Date(timeIntervalSince1970: 1682812800), // 2023/04/30 00:00
				Date(timeIntervalSince1970: 1685491200), // 2023/05/31 00:00
				Date(timeIntervalSince1970: 1688083200), // 2023/06/30 00:00
				Date(timeIntervalSince1970: 1690761600), // 2023/07/31 00:00
				Date(timeIntervalSince1970: 1693440000), // 2023/08/31 00:00
				Date(timeIntervalSince1970: 1696032000), // 2023/09/30 00:00
				Date(timeIntervalSince1970: 1698710400), // 2023/10/31 00:00
				Date(timeIntervalSince1970: 1701302400), // 2023/11/30 00:00
				Date(timeIntervalSince1970: 1703980800)  // 2023/12/31 00:00
		]
	}
	
	private func daysOfMonthStubs() -> [Int] {
		return [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30 ,31]
	}
	
	private func firstDateOffSetStubs() -> [Int] {
		return [1, 4, 4, 7, 2, 5, 7, 3, 6, 1, 4, 6]
	}

}
