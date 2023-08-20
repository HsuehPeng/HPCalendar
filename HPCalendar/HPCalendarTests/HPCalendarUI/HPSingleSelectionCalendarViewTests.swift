//
//  UICalendarViewTests.swift
//  HPCalendarTests
//
//  Created by Hsueh Peng Tseng on 2023/8/17.
//

import XCTest
import UIKit
@testable import HPCalendar

final class HPSingleSelectionCalendarViewTests: XCTestCase {

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
	
	// MARK: - Helpers
	
	private func makeSut(date: Date = Date()) -> (HPSingleSelectionCalendarView, HPSingleCalendarViewModel) {
		let calendar = Calendar(identifier: .gregorian)
		let dayLoader = HPDayLoaderDummy()
		let hpdayLoaderAdapterSpy = HPDayLoaderAdapterSpy(adaptee: dayLoader) { hpday in
			return HPSingleSelectionDay(date: hpday.date, number: hpday.number, isWithInMonth: hpday.isWithInMonth, isToday: false)
		}
		
		let calendarManager = HPCalendarManager(calendar: calendar)
		let headerTextFormate = "MM"
		let vm = HPSingleCalendarViewModel(baseDate: date, dayLoader: hpdayLoaderAdapterSpy, calendarManager: calendarManager, headerTextFormate: headerTextFormate)
		let sut = HPSingleSelectionCalendarView(frame: .zero, viewModel: vm)
		return (sut, vm)
	}

	var numbersOfCalendarCell = HPCalendarPolicy.numbersOfCell
	
	private class HPDayLoaderDummy: HPDayLoader {
		func generateHPDaysInMonth(for date: Date) -> [HPDay] {
			return []
		}
	}
	
	private class HPDayLoaderAdapterSpy: HPDayLoaderAdapter<HPSingleSelectionDay> {
		var generateDaysCount = 0
		
		override func load(for date: Date) -> [HPSingleSelectionDay] {
			generateDaysCount += 1
			return Array(repeating: HPSingleSelectionDay(date: Date(), number: "1", isWithInMonth: true, isToday: true), count: HPCalendarPolicy.numbersOfCell)
		}
	}
}
