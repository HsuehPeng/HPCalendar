//
//  UICalendarViewTests.swift
//  HPCalendarTests
//
//  Created by Hsueh Peng Tseng on 2023/8/17.
//

import XCTest
import UIKit
@testable import HPCalendar

final class HPCalendarViewTests: XCTestCase {

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
	
	private func makeSut(date: Date = Date()) -> (HPCalendarView, MockHPCalendarVM) {
		let vm = MockHPCalendarVM(baseDate: date)
		let sut = HPCalendarView(frame: .zero, viewModel: vm)
		return (sut, vm)
	}
	
	class MockHPCalendarVM: HPCalendarViewModel {
		var baseDate: Date 
		 
		var days: [HPDay] = Array(repeating: HPDay(date: Date(), number: "1", isWithInMonth: true), count: 35)
		
		var onSetBaseDate: (() -> Void)?
		
		var headerText: String {
			return headerTexts[headerTextsIndex]
		}
		
		func setNextBaseDate() {
			guard headerTextsIndex < headerTexts.count else { return }
			headerTextsIndex += 1
			onSetBaseDate?()
		}
		
		func setPreviousBaseDate() {
			guard headerTextsIndex > 0 else { return }
			headerTextsIndex -= 1
			onSetBaseDate?()
		}
		
		// MARK: Helpers
		
		private var headerTexts: [String] = ["August 2023", "September 2023"]
		private var headerTextsIndex = 0
		
		init(baseDate: Date) {
			self.baseDate = baseDate
		}
	}
	
	var numbersOfCalendarCell = 35
}
