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
		let selectionDay = HPSelectionDay(date: Date(), number: "1", isWithInMonth: false, isToday: false, isSelected: false)
		let sut = makeSut(selectionDay)
		
		XCTAssertEqual(sut.dateNumber, selectionDay.number)
	}
	
	func test_dateTextColor_renderCorrectTextColorWhenDayIsWithInMonthButNotTodayAndNotSelected() {
		let selectionDay = HPSelectionDay(date: Date(), number: "1", isWithInMonth: true, isToday: false, isSelected: false)
		let sut = makeSut(selectionDay)
		
		XCTAssertEqual(sut.dateTextColor, HPCalendarColorConstant.withinMonthTextColor)
	}
	
	func test_dateTextColor_renderCorrectTextColorWhenDayIsWithInMonthAndIsTodayAndNotSelected() {
		let selectionDay = HPSelectionDay(date: Date(), number: "1", isWithInMonth: true, isToday: true, isSelected: false)
		let sut = makeSut(selectionDay)
		
		XCTAssertEqual(sut.dateTextColor, HPCalendarColorConstant.todayTextColor)
	}
	
	func test_dateTextColor_renderCorrectTextColorWhenDayIsWithInMonthAndIsTodayAndIsSelected() {
		let selectionDay = HPSelectionDay(date: Date(), number: "1", isWithInMonth: true, isToday: true, isSelected: true)
		let sut = makeSut(selectionDay)
		
		XCTAssertEqual(sut.dateTextColor, HPCalendarColorConstant.selectedTextColor)
	}
	
	func test_dateTextColor_renderCorrectTextColorWhenDayIsWithInMonthButIsNotTodayAndIsSelected() {
		let selectionDay = HPSelectionDay(date: Date(), number: "1", isWithInMonth: true, isToday: false, isSelected: true)
		let sut = makeSut(selectionDay)
		
		XCTAssertEqual(sut.dateTextColor, HPCalendarColorConstant.selectedTextColor)
	}
	
	func test_dateTextColor_renderCorrectTextColorWhenDayIsNotWithInMonthButNotTodayAndNotSelected() {
		let selectionDay = HPSelectionDay(date: Date(), number: "1", isWithInMonth: false, isToday: false, isSelected: false)
		let sut = makeSut(selectionDay)
		
		XCTAssertEqual(sut.dateTextColor, HPCalendarColorConstant.notWithinMonthTextColor)
	}
	
	func test_dateTextColor_renderCorrectTextColorWhenDayIsNotWithInMonthButAccidentallyIsTodayAndIsSelected() {
		let selectionDay = HPSelectionDay(date: Date(), number: "1", isWithInMonth: false, isToday: true, isSelected: false)
		let sut = makeSut(selectionDay)
		
		XCTAssertEqual(sut.dateTextColor, HPCalendarColorConstant.notWithinMonthTextColor)
	}
	
	func test_isSelectionViewHidden_validateCorrectSelectionViewHiddenState() {
		let selectionDay = HPSelectionDay(date: Date(), number: "1", isWithInMonth: false, isToday: false, isSelected: false)
		let sut = makeSut(selectionDay)
		
		XCTAssertEqual(sut.isSelectionViewHidden, !selectionDay.isSelected)
	}

	// MARK: - Helpers
	
	private func makeSut(_ selectionDay: HPSelectionDay, file: StaticString = #filePath, line: UInt = #line) -> HPCalendarCellViewModel {
		let viewModel = HPCalendarCellViewModel(day: selectionDay)
		
		trackForMemoryLeaks(viewModel, file: file, line: line)

		return viewModel
	}
}
