//
//  HPRangeSelectionManagerTests.swift
//  HPCalendarTests
//
//  Created by Hsueh Peng Tseng on 2023/8/28.
//

import XCTest
@testable import HPCalendar

final class HPRangeSelectionManagerTests: XCTestCase {
	override func setUp() {
		closureMessage = []
	}
	
	override func tearDown() {
		closureMessage = []
	}
	
	func test_baseDate_triggerOnReloadCalendarWhenchangeBaseDate() {
		let sut = makeSut()
		
		sut.baseDate = today
		
		XCTAssertEqual(closureMessage, [.reloadCalendar])
	}
	
	func test_loadDays_returnCorrectHPSelectionDay() {
		let sut = makeSut()
		let testedHPSelectionDays = [
			HPSelectionDay(date: sut.baseDate, number: "1", isWithInMonth: true, isToday: true, isSelected: false),
			HPSelectionDay(date: addOneDay(on: sut.baseDate), number: "2", isWithInMonth: true, isToday: false, isSelected: false),
			HPSelectionDay(date: addOneMonth(on: sut.baseDate), number: "3", isWithInMonth: false, isToday: false, isSelected: false)
		]
		
		let hpSelectionDays = sut.loadDays()
		
		XCTAssertEqual(hpSelectionDays, testedHPSelectionDays)
	}
	
	func test_calendarHeaderText_returnCorrectHeaderText() {
		let sut = makeSut()
		let testedHeaderText = formattedDate(sut.baseDate)
		
		let headerText = sut.calendarHeaderText()
		
		XCTAssertEqual(headerText, testedHeaderText)
	}
	
	func test_setNextBaseDate_baseDateAddOneMonth() {
		let sut = makeSut()
		let baseDateAddOneMonth = addOneMonth(on: sut.baseDate)
		
		sut.setNextBaseDate()
		
		XCTAssertEqual(sut.baseDate, baseDateAddOneMonth)
	}
	
	func test_setPreviousBaseDate_baseDateMinusOneMonth() {
		let sut = makeSut()
		let baseDateMinusOneMonth = minusOneMonth(on: sut.baseDate)
		
		sut.setPreviousBaseDate()
		
		XCTAssertEqual(sut.baseDate, baseDateMinusOneMonth)
	}
	
	func test_selectedDate_triggerOnSelectedDateAndOnReloadCalendarWhenchangeSelectedDate() {
		let sut = makeSut()
		
		sut.selectedDate = (today, today)
		sut.selectedDate = (nil, nil)
		
		XCTAssertEqual(closureMessage, [.selectedDate, .reloadCalendar, .selectedDate, .reloadCalendar])
	}
	
	func test_setSelectedDate_checkCorrectSelectedDateWhenInitialSelectedDatesAreNil() {
		let sut = makeSut()
		let today = today

		sut.setSelectedDate(today)
		
		XCTAssertEqual(sut.selectedDate.startDate, today)
		XCTAssertEqual(sut.selectedDate.endDate, nil)
	}
	
	func test_setSelectedDate_checkSelectedDatesAreNilWhenInitialSelectedStartDateSameAsNewlySelectedDate() {
		let sut = makeSut()
		let today = today
		let nextDay = addOneDay(on: today)
		sut.selectedDate = (today, nextDay)

		sut.setSelectedDate(today)
		
		XCTAssertEqual(sut.selectedDate.startDate, nil)
		XCTAssertEqual(sut.selectedDate.endDate, nil)
	}
	
	func test_setSelectedDate_checkCorrectSelectedDateWhenNewlySelectedDateIsLessThanStartDate() {
		let sut = makeSut()
		let today = today
		let nextDay = addOneDay(on: today)
		let previousDay = minusOneDay(on: today)
		sut.selectedDate = (today, nextDay)

		sut.setSelectedDate(previousDay)
		
		XCTAssertEqual(sut.selectedDate.startDate, previousDay)
		XCTAssertEqual(sut.selectedDate.endDate, nextDay)
	}
	
	func test_setSelectedDate_checkCorrectSelectedDateWhenNewlySelectedDateIsGreaterThanStartDate() {
		let sut = makeSut()
		let today = today
		let nextDay = addOneDay(on: today)
		let nextTwoDay = addOneDay(on: nextDay)
		sut.selectedDate = (today, nextDay)

		sut.setSelectedDate(nextTwoDay)
		
		XCTAssertEqual(sut.selectedDate.startDate, today)
		XCTAssertEqual(sut.selectedDate.endDate, nextTwoDay)
		
		sut.setSelectedDate(nextDay)
		
		XCTAssertEqual(sut.selectedDate.startDate, today)
		XCTAssertEqual(sut.selectedDate.endDate, nextDay)
	}

	// MARK: - Helpers
	
	private func makeSut() -> HPRangeSelectionManager {
		let calendar = calendar
		let dayLoader = HPDayLoaderSpy()
		let sut = HPRangeSelectionManager(calendar: calendar, dayLoader: dayLoader, headerTextFormate: headerFormate)
		
		sut.onReloadCalendar = { [weak self] in
			self?.closureMessage.append(.reloadCalendar)
		}
		
		sut.onSelectedDate = { [weak self] (_, _) in
			self?.closureMessage.append(.selectedDate)
		}
		
		trackForMemoryLeaks(dayLoader)
		trackForMemoryLeaks(sut)
		
		return sut
	}
		
	private enum ClosureMessage {
		case selectedDate
		case reloadCalendar
	}
	
	private var closureMessage: [ClosureMessage] = []
	
	private let headerFormate = "mm"
	
	private let today = Date()
	
	private let calendar = makeTestCalendar()

	private func formattedDate(_ date: Date) -> String {
		let formatter = DateFormatter()
		formatter.dateFormat = headerFormate
		formatter.calendar = calendar
		
		return formatter.string(from: date)
	}
	
	private func addOneMonth(on date: Date) -> Date {
		return calendar.date(byAdding: .month, value: 1, to: date)!
	}
	
	private func minusOneMonth(on date: Date) -> Date {
		return calendar.date(byAdding: .month, value: -1, to: date)!
	}
	
	private func addOneDay(on date: Date) -> Date {
		return calendar.date(byAdding: .day, value: 1, to: date)!
	}
	
	private func minusOneDay(on date: Date) -> Date {
		return calendar.date(byAdding: .day, value: -1, to: date)!
	}
	
	private class HPDayLoaderSpy: HPDayLoader {
		private let calendar = makeTestCalendar()
		
		func generateHPDaysInMonth(for date: Date) -> [HPDay] {
			return [
				HPDay(date: date, number: "1", isWithInMonth: true),
				HPDay(date: addOneDay(on: date), number: "2", isWithInMonth: true),
				HPDay(date: addOneMonth(on: date), number: "3", isWithInMonth: false)
			]
		}
		
		private func addOneMonth(on date: Date) -> Date {
			return calendar.date(byAdding: .month, value: 1, to: date)!
		}
		
		private func addOneDay(on date: Date) -> Date {
			return calendar.date(byAdding: .day, value: 1, to: date)!
		}
	}

}
