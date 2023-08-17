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
	
	func test_headerView_renderCorrectDateFormate() {
		let (sut, vm) = makeSut()
		
		XCTAssertEqual(sut.headerView.dateLabel.text, vm.headerText())
	}
	
	func test_collectionViewCell_renderCorrectDateNumber() {
		let (sut, vm) = makeSut()
		
		for i in 0...34 {
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
		
		var days: [HPDay]
		
		func headerText() -> String {
			return "March 2023"
		}
		
		init(baseDate: Date, days: [HPDay] = Array(repeating: HPDay(date: Date(), number: "1", isWithInMonth: true), count: 35)) {
			self.baseDate = baseDate
			self.days = days
		}
	}
	
	var numbersOfCalendarCell = 35
}
