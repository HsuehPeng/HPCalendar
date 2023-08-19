//
//  CalendarDataSource.swift
//  HPCalendarTests
//
//  Created by Hsueh Peng Tseng on 2023/8/16.
//

import XCTest
@testable import HPCalendar

final class NativeHPDaysLoaderTests: XCTestCase {
	
	func test_generateDaysInMonth_getDaysCountByGivenMonth() {
		let (sut, metaDataProvider) = makeSut()

		let days = sut.generateHPDaysInMonth(for: Date())
		
		XCTAssertEqual(days.count, metaDataProvider.HPDaysArrayStub.count)
	}
	
	func test_generateDaysInMonth_getCorrectHPDays() {
		let (sut, metaDataProvider) = makeSut()

		let days = sut.generateHPDaysInMonth(for: Date())
		
		for i in 0..<days.count {
			XCTAssertEqual(days[i].date, metaDataProvider.HPDaysArrayStub[i].date)
			XCTAssertEqual(days[i].isWithInMonth, metaDataProvider.HPDaysArrayStub[i].isWithInMonth)
			XCTAssertEqual(days[i].number, metaDataProvider.HPDaysArrayStub[i].number)
		}
	}
	
	// MARK: - Helpers
	
	private func makeSut() -> (NativeHPDaysLoader, MetaDataProviderMock) {
		var calendar = Calendar(identifier: .gregorian)
		calendar.timeZone = .gmt
		let metaDataProvider = MetaDataProviderMock(calendar: calendar)
		let sut = NativeHPDaysLoader(calendar: calendar, metaDataProvider: metaDataProvider)
		
		return (sut, metaDataProvider)
	}
	
	class MetaDataProviderMock: MetaDataProvider {
		private let onlyDateInMonth = Date(timeIntervalSince1970: 86400)
		
		private func dateNumberFormate(for date: Date) -> String {
			let formatter = DateFormatter()
			formatter.dateFormat = "d"
			formatter.calendar = makeTestCalendar()
			
			return formatter.string(from: date)
		}
		
		lazy var HPDaysArrayStub = [HPDay(date: Date(timeIntervalSince1970: 0), number: dateNumberFormate(for: Date(timeIntervalSince1970: 0)), isWithInMonth: false),
									HPDay(date: Date(timeIntervalSince1970: 86400), number: dateNumberFormate(for: Date(timeIntervalSince1970: 86400)), isWithInMonth: true),
									HPDay(date: Date(timeIntervalSince1970: 172800), number: dateNumberFormate(for: Date(timeIntervalSince1970: 172800)), isWithInMonth: false)
		]
		
		override func numbersOfDaysInMonth(for date: Date) -> Int {
			return 1
		}
		
		override func getFirstDateOfMonth(for date: Date) -> Date {
			onlyDateInMonth
		}
		
		override func getLastDateOfMonth(for date: Date) -> Date {
			onlyDateInMonth
		}
		
		override func firstDateOffSet(for date: Date) -> Int {
			2
		}
		
		override func nextMonthWeekDayOffSet(for date: Date) -> Int {
			1
		}
	}
	
	
	
}
