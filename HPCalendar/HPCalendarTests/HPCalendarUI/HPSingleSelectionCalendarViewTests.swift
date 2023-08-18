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
		let (sut, vm) = makeSut()

		XCTAssertEqual(sut.numbersOfCalendarCell(), numbersOfCalendarCell)
		XCTAssertEqual(vm.days.count, numbersOfCalendarCell)
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
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "MM"
		let calendar = Calendar(identifier: .gregorian)
		let vm = HPSingleCalendarViewModel(baseDate: date, dateFormater: dateFormatter, calendar: calendar)
		let sut = HPSingleSelectionCalendarView(frame: .zero, viewModel: vm)
		return (sut, vm)
	}

	var numbersOfCalendarCell = 35
}
