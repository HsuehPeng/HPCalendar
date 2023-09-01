//
//  HPCalendarCellViewModelTests.swift
//  HPCalendarTests
//
//  Created by Hsueh Peng Tseng on 2023/8/25.
//

import XCTest
@testable import HPCalendar

final class HPCalendarCellViewModelTests: XCTestCase {
	
	func test_dateNumber_validateCorrectDateNumber() {
		let selectionDay = makeHPSelectionDay()
		let sut = makeSut(selectionDay)
		
		XCTAssertEqual(sut.dateNumber, selectionDay.number)
	}
	
	func test_dateTextColor_renderCorrectTextColorStateWhenDayIsWithInMonthButNotTodayAndNotSelected() {
		let selectionDay = makeHPSelectionDay(isWithInMonth: true)
		let sut = makeSut(selectionDay)
		
		XCTAssertEqual(sut.dateTextColorState, .inMonth)
	}
	
	func test_dateTextColor_renderCorrectTextColorStateWhenDayIsWithInMonthAndIsTodayAndNotSelected() {
		let selectionDay = makeHPSelectionDay(isWithInMonth: true, isToday: true)
		let sut = makeSut(selectionDay)
		
		XCTAssertEqual(sut.dateTextColorState, .today)
	}
	
	func test_dateTextColor_renderCorrectTextColorStateWhenDayIsWithInMonthAndIsTodayAndIsSelected() {
		let selectionDay = makeHPSelectionDay(isWithInMonth: true, isToday: true, isSelected: true)
		let sut = makeSut(selectionDay)
		
		XCTAssertEqual(sut.dateTextColorState, .selected)
	}
	
	func test_dateTextColor_renderCorrectTextColorStateWhenDayIsWithInMonthButIsNotTodayAndIsSelected() {
		let selectionDay = makeHPSelectionDay(isWithInMonth: true, isSelected: true)
		let sut = makeSut(selectionDay)
		
		XCTAssertEqual(sut.dateTextColorState, .selected)
	}
	
	func test_dateTextColor_renderCorrectTextColorStateWhenDayIsNotWithInMonthButNotTodayAndNotSelected() {
		let selectionDay = makeHPSelectionDay()
		let sut = makeSut(selectionDay)
		
		XCTAssertEqual(sut.dateTextColorState, .notInMonth)
	}
	
	func test_dateTextColor_renderCorrectTextColorStateWhenDayIsNotWithInMonthButAccidentallyIsTodayAndIsSelected() {
		let selectionDay = makeHPSelectionDay(isToday: true)
		let sut = makeSut(selectionDay)
		
		XCTAssertEqual(sut.dateTextColorState, .notInMonth)
	}
	
	func test_isSelectionViewHidden_validateCorrectSelectionViewHiddenState() {
		let selectionDay = makeHPSelectionDay(isSelected: true)
		let sut = makeSut(selectionDay)
		
		XCTAssertEqual(sut.isSelectionViewHidden, !selectionDay.isSelected)
	}
	
	func test_isEventDotHidden_validateCorrectEventDotHiddenState() {
		let selectionDay = makeHPSelectionDay(hasEvent: true)
		let sut = makeSut(selectionDay)
		
		XCTAssertEqual(sut.isEventDotHidden, !selectionDay.hasEvent)
	}

	// MARK: - Helpers
	
	private func makeSut(_ selectionDay: HPSelectionDay, file: StaticString = #filePath, line: UInt = #line) -> HPCalendarCellViewModel {
		let viewModel = HPCalendarCellViewModel(day: selectionDay)
		
		trackForMemoryLeaks(viewModel, file: file, line: line)

		return viewModel
	}
	
	private func makeHPSelectionDay(
		date: Date = Date(),
		number: String = "1",
		isWithInMonth: Bool = false,
		isToday: Bool = false,
		isSelected: Bool = false,
		hasEvent: Bool = false) -> HPSelectionDay {
		return HPSelectionDay(date: date, number: number, isWithInMonth: isWithInMonth, isToday: isToday, isSelected: isSelected, hasEvent: hasEvent)
	}
}
