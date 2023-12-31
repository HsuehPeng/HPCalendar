//
//  HPSingleSelectionManagerTests.swift
//  HPCalendarTests
//
//  Created by Hsueh Peng Tseng on 2023/8/25.
//

import XCTest
@testable import HPCalendar

final class HPSingleSelectionManagerTests: XCTestCase {
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
	
	func test_loadDays_returnCorrectHPSelectionDay() { //
		let sut = makeSut()
		let testedHPSelectionDays = [
			HPSelectionDay(date: sut.baseDate, number: "1", isWithInMonth: true, isToday: true, isSelected: false, hasEvent: false),
			HPSelectionDay(date: addOneDay(on: sut.baseDate), number: "2", isWithInMonth: true, isToday: false, isSelected: false, hasEvent: false),
			HPSelectionDay(date: addOneMonth(on: sut.baseDate), number: "3", isWithInMonth: false, isToday: false, isSelected: false, hasEvent: false)
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
		
		sut.selectedDate = Date()
		sut.selectedDate = nil
		
		XCTAssertEqual(closureMessage, [.selectedDate, .reloadCalendar, .selectedDate, .reloadCalendar])
	}
	
	func test_setSelectedDate_checkCorrectSelectedDate() {
		let sut = makeSut()
		let today = today
		let nextDay = addOneDay(on: today)
		
		sut.setSelectedDate(today)
		XCTAssertEqual(sut.selectedDate, today)
		
		sut.setSelectedDate(nextDay)
		XCTAssertEqual(sut.selectedDate, nextDay)
		
		sut.setSelectedDate(nextDay)
		XCTAssertEqual(sut.selectedDate, nil)
	}

	// MARK: - Helpers
	
	private func makeSut() -> HPSingleSelectionManager {
		let calendar = calendar
		let dayLoader = HPDayLoaderSpy()
		let sut = HPSingleSelectionManager(calendar: calendar, dayLoader: dayLoader, events: [])
		
		sut.onReloadCalendar = { [weak self] in
			self?.closureMessage.append(.reloadCalendar)
		}
		
		sut.onSelectedDate = { [weak self] result in
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
	
	private let headerFormate = HPCalendarPolicy.headerTextFormate
	
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
