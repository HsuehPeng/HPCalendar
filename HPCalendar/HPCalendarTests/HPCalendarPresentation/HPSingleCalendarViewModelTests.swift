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
		let (sut, _, _) = makeSut(baseDate: currentDate)
		
		XCTAssertEqual(sut.baseDate, currentDate)
	}
	
	func test_init_renderCorrectHeaderDate() {
		let currentDate = Date()
		let (sut, _, _) = makeSut(baseDate: currentDate)
		let dateFormatter = makeDateFormatterTestHelper()

		XCTAssertEqual(sut.headerText, dateFormatter.string(from: currentDate))
	}
	
	func test_generateHPDays_dayLoaderGenerateHPDaysCallCount() {
		let (sut, dayLoader, _) = makeSut()
		XCTAssertEqual(dayLoader.generateDaysCount, 1)
		
		sut.baseDate = Date()
		XCTAssertEqual(dayLoader.generateDaysCount, 2)
		
		sut.setNextBaseDate()
		XCTAssertEqual(dayLoader.generateDaysCount, 3)
		
		sut.setPreviousBaseDate()
		XCTAssertEqual(dayLoader.generateDaysCount, 4)
	}
	
	func test_setNextBaseDate_HPCalendarManagerAddTimeUnitCallCount() {
		let (sut, _, manager) = makeSut()
		
		sut.setNextBaseDate()
		
		XCTAssertEqual(manager.messages, [.addTimeUnit])
	}
	
	func test_setNextBaseDateTwice_HPCalendarManagerAddTimeUnitCallCount() {
		let (sut, _, manager) = makeSut()
		
		sut.setNextBaseDate()
		sut.setNextBaseDate()
		
		XCTAssertEqual(manager.messages, [.addTimeUnit, .addTimeUnit])
	}
	
	func test_setPreviousBaseDate_baseDateChangeToPreviousBaseDate() {
		let (sut, _, manager) = makeSut()
		
		sut.setPreviousBaseDate()

		XCTAssertEqual(manager.messages, [.minusTimeUnit])
	}
	
	func test_setPreviousBaseDateTwice_baseDateChangeToPreviousBaseDate() {
		let (sut, _, manager) = makeSut()
		
		sut.setPreviousBaseDate()
		sut.setPreviousBaseDate()

		XCTAssertEqual(manager.messages, [.minusTimeUnit, .minusTimeUnit])
	}
	
	// MARK: - Helpers
	
	private func makeSut(baseDate: Date = Date()) -> (HPSingleCalendarViewModel, HPDayLoaderSpy, HPCalendarManagerSpy) {
		let daysLoader = HPDayLoaderSpy()
		let calendar = makeTestCalendar()
		let calendarManager = HPCalendarManagerSpy(calendar: calendar)
		let sut = HPSingleCalendarViewModel(baseDate: baseDate, dayLoader: daysLoader, calendarManager: calendarManager, headerTextFormate: headerDateFormateHelper)

		return (sut, daysLoader, calendarManager)
	}
	
	private func makeDateFormatterTestHelper() -> DateFormatter {
		let formatter = DateFormatter()
		formatter.calendar = makeTestCalendar()
		formatter.dateFormat = headerDateFormateHelper
		return formatter
	}
	
	private var headerDateFormateHelper: String {
		return "MMMM yyyy"
	}
	
	private class HPDayLoaderSpy: HPDayLoader {
		var generateDaysCount = 0
		
		func generateHPDaysInMonth(for date: Date) -> [HPDay] {
			generateDaysCount += 1
			return []
		}
	}
	
	private class HPCalendarManagerSpy: HPCalendarManager {
		enum Message {
			case addTimeUnit
			case minusTimeUnit
		}
		
		var messages: [Message] = []
		
		override func addTimeUnit(with component: Calendar.Component, to date: Date) -> Date {
			messages.append(.addTimeUnit)
			return Date()
		}
		
		override func minusTimeUnit(with component: Calendar.Component, to date: Date) -> Date {
			messages.append(.minusTimeUnit)
			return Date()
		}
	}

}
