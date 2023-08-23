//
//  UICalendarViewTests.swift
//  HPCalendarTests
//
//  Created by Hsueh Peng Tseng on 2023/8/17.
//

import XCTest
import UIKit
@testable import HPCalendar

final class HPSingleSelectionCalendarUIIntegrationTests: XCTestCase {

	func test_init_renderCorrectNumbersOfCalendarCell() {
		let (sut, _) = makeSut()

		XCTAssertEqual(sut.numbersOfCalendarCell(), numbersOfCalendarCell)
	}
	
	func test_init_renderCorrectHeaderTextOnCreation() {
		let (sut, vm) = makeSut()
		
		XCTAssertEqual(sut.headerView.dateLabel.text, vm.headerText)
	}
	
	func test_headerView_changeHeaderViewDateLabelTextWhenTapNextMonthAndPreviousMonthButton() {
		let (sut, vm) = makeSut()
		XCTAssertEqual(sut.headerView.dateLabel.text, vm.headerText)

		sut.simnulateHeaderViewTapNextButton()
		XCTAssertEqual(sut.headerView.dateLabel.text, vm.headerText)

		sut.simnulateHeaderViewTapPreviousButton()
		XCTAssertEqual(sut.headerView.dateLabel.text, vm.headerText)
	}
	
	func test_collectionViewCell_renderCorrectDateNumber() {
		let (sut, vm) = makeSut()

		for i in 0...(numbersOfCalendarCell-1) {
			XCTAssertEqual(sut.calendarCellDateNumber(at: i), vm.days[i].number)
		}
	}
	
	func test_HPCalendarCell_renderCorrectDateLabelTextColor() {
		let (sut, _) = makeSut()
				
		for i in 0..<5 {
			XCTAssertEqual(sut.calendarCellDateLabelTextColor(at: i), HPSingleSelectionCalendarUIConfiguration.notWithinMonthTextColor)
		}
		
		for i in 5..<6 {
			XCTAssertEqual(sut.calendarCellDateLabelTextColor(at: i), HPSingleSelectionCalendarUIConfiguration.todayTextColor)
		}
		
		for i in 6..<36 {
			XCTAssertEqual(sut.calendarCellDateLabelTextColor(at: i), HPSingleSelectionCalendarUIConfiguration.withinMonthTextColor)
		}
		
		for i in 36..<42 {
			XCTAssertEqual(sut.calendarCellDateLabelTextColor(at: i), HPSingleSelectionCalendarUIConfiguration.notWithinMonthTextColor)
		}
	}
	
	func test_selectHPCalendarCell_doNothingWhenSelectCellThatIsNotInCurrentMonth() {
//		let (sut, _) = makeSut()
//		
//		sut.simulateSelectHpCalendarCell(at: beforeCurrentMonthIndex)
//		
//		XCTAssertEqual(sut.calendarCellSelectionViewColor(at: beforeCurrentMonthIndex), UIColor.clear)
//		XCTAssertEqual(sut.calendarCellDateLabelTextColor(at: beforeCurrentMonthIndex), HPSingleSelectionCalendarUIConfiguration.notWithinMonthTextColor)
	}
	
	func test_selectHPCalendarCell_verifyCellUIWhenSelectCellThatIsInCurrentMonth() {
//		let (sut, _) = makeSut()
//
//		sut.simulateSelectHpCalendarCell(at: currentMonthIndex)
//
//		XCTAssertEqual(sut.calendarCellSelectionViewColor(at: currentMonthIndex), HPSingleSelectionCalendarUIConfiguration.calendarCellSelectionColor)
//		XCTAssertEqual(sut.calendarCellDateLabelTextColor(at: currentMonthIndex), .white)
	}
	
	func test_selectHPCalendarCell_verifyCellUIWhenSelectCellTwiceThatIsInCurrentMonth() {
//		let (sut, _) = makeSut()
//
//		sut.simulateSelectHpCalendarCell(at: currentMonthIndex)
//		sut.simulateSelectHpCalendarCell(at: currentMonthIndex)
//
//		XCTAssertEqual(sut.calendarCellSelectionViewColor(at: currentMonthIndex), UIColor.clear)
//		XCTAssertEqual(sut.calendarCellDateLabelTextColor(at: currentMonthIndex), HPSingleSelectionCalendarUIConfiguration.withinMonthTextColor)
	}
	
	func test_selectHPCalendarCell_verifyCellUIWhenSelectCellThatIsToday() {
//		let (sut, _) = makeSut()
//
//		sut.simulateSelectHpCalendarCell(at: todayIndex)
//
//		XCTAssertEqual(sut.calendarCellSelectionViewColor(at: todayIndex), HPSingleSelectionCalendarUIConfiguration.calendarCellSelectionColor)
//		XCTAssertEqual(sut.calendarCellDateLabelTextColor(at: todayIndex), .white)
	}
	
	func test_selectHPCalendarCell_verifyCellUIWhenSelectCellTwiceThatIsIsToday() {
//		let (sut, _) = makeSut()
//
//		sut.simulateSelectHpCalendarCell(at: todayIndex)
//		sut.simulateSelectHpCalendarCell(at: todayIndex)
//
//		XCTAssertEqual(sut.calendarCellSelectionViewColor(at: todayIndex), UIColor.clear)
//		XCTAssertEqual(sut.calendarCellDateLabelTextColor(at: todayIndex), HPSingleSelectionCalendarUIConfiguration.todayTextColor)
	}
	
	func test_selectHPCalendarCell_verifyCellUIWhenSelectACellFirstAndSelectionAnotherCell() {
//		let (sut, _) = makeSut()
//
//		sut.simulateSelectHpCalendarCell(at: currentMonthIndex)
//
//		XCTAssertEqual(sut.calendarCellSelectionViewColor(at: currentMonthIndex), HPSingleSelectionCalendarUIConfiguration.calendarCellSelectionColor)
//		XCTAssertEqual(sut.calendarCellDateLabelTextColor(at: currentMonthIndex), .white)
//
//		sut.simulateSelectHpCalendarCell(at: anotherCurrentMonthIndex)
//
//		XCTAssertEqual(sut.calendarCellSelectionViewColor(at: currentMonthIndex), UIColor.clear)
//		XCTAssertEqual(sut.calendarCellDateLabelTextColor(at: currentMonthIndex), HPSingleSelectionCalendarUIConfiguration.withinMonthTextColor)
//		XCTAssertEqual(sut.calendarCellSelectionViewColor(at: anotherCurrentMonthIndex), HPSingleSelectionCalendarUIConfiguration.calendarCellSelectionColor)
//		XCTAssertEqual(sut.calendarCellDateLabelTextColor(at: anotherCurrentMonthIndex), .white)
	}

	func test_selectHPCalendarCell_verifyCellUIWhenSelectTodayCellFirstAndSelectionAnotherCell() {
//		let (sut, _) = makeSut()
//
//		sut.simulateSelectHpCalendarCell(at: todayIndex)
//
//		XCTAssertEqual(sut.calendarCellSelectionViewColor(at: todayIndex), HPSingleSelectionCalendarUIConfiguration.calendarCellSelectionColor)
//		XCTAssertEqual(sut.calendarCellDateLabelTextColor(at: todayIndex), .white)
//
//		sut.simulateSelectHpCalendarCell(at: anotherCurrentMonthIndex)
//
//		XCTAssertEqual(sut.calendarCellSelectionViewColor(at: todayIndex), UIColor.clear)
//		XCTAssertEqual(sut.calendarCellDateLabelTextColor(at: todayIndex), HPSingleSelectionCalendarUIConfiguration.todayTextColor)
//		XCTAssertEqual(sut.calendarCellSelectionViewColor(at: anotherCurrentMonthIndex), HPSingleSelectionCalendarUIConfiguration.calendarCellSelectionColor)
//		XCTAssertEqual(sut.calendarCellDateLabelTextColor(at: anotherCurrentMonthIndex), .white)
	}
	
	// MARK: - Helpers
	
	private func makeSut(date: Date = Date()) -> (HPSingleSelectionCalendarView, HPSingleCalendarViewModel) {
		let calendar = Calendar(identifier: .gregorian)
		let dayLoader = HPDayLoaderDummy()
		let hpdayLoaderAdapterSpy = HPDayLoaderAdapterSpy(adaptee: dayLoader) { hpday in
			return HPSingleSelectionDay(date: hpday.date, number: hpday.number, isWithInMonth: hpday.isWithInMonth, isToday: false, isSelected: false)
		}
		
		let calendarManager = HPSingleSelectionManager(calendar: calendar)
		let headerTextFormate = "MM"
		let vm = HPSingleCalendarViewModel(dayLoader: hpdayLoaderAdapterSpy, calendarManager: calendarManager, headerTextFormate: headerTextFormate)
		let sut = HPSingleSelectionCalendarView(frame: .zero, viewModel: vm)
		return (sut, vm)
	}

	var numbersOfCalendarCell = HPCalendarPolicy.numbersOfCell
	
	let beforeCurrentMonthIndex = 0
	let currentMonthIndex = 10
	let anotherCurrentMonthIndex = 11
	let todayIndex = 2
	
	private class HPDayLoaderDummy: HPDayLoader {
		func generateHPDaysInMonth(for date: Date) -> [HPDay] {
			return []
		}
	}
	
	private class HPDayLoaderAdapterSpy: HPDayLoaderAdapter<HPSingleSelectionDay> {
		var generateDaysCount = 0
		
		override func load(for date: Date) -> [HPSingleSelectionDay] {
			generateDaysCount += 1
			
			let notWithinMonthDayBeforeCurrentMonth = Array(repeating: HPSingleSelectionDay(date: Date(), number: "1", isWithInMonth: false, isToday: false, isSelected: false), count: 5)
			let todayDay = [HPSingleSelectionDay(date: Date(), number: "2", isWithInMonth: true, isToday: true, isSelected: false)]
			let withinMonthDays = Array(repeating: HPSingleSelectionDay(date: Date(), number: "3", isWithInMonth: true, isToday: false, isSelected: false), count: 30)
			let notWithinMonthDayAfterCurrentMonth = Array(repeating: HPSingleSelectionDay(date: Date(), number: "4", isWithInMonth: false, isToday: false, isSelected: false), count: 6)
			
			let hpSingleSelectionDays = notWithinMonthDayBeforeCurrentMonth + todayDay + withinMonthDays + notWithinMonthDayAfterCurrentMonth
			
			return hpSingleSelectionDays
		}
	}
}
