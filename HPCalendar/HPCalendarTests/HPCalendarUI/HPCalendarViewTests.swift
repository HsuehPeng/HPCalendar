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
	
	func test_collectionViewCell_renderCorrectDateNumber() {
		let (sut, vm) = makeSut()
		
		for i in 0...34 {
			XCTAssertEqual(sut.calendarCellDateNumber(at: i), vm.days[i].number)
		}
	}
	
	// MARK: - Helpers
	
	private func makeSut() -> (HPCalendarView, MockHPCalendarVM) {
		let vm = MockHPCalendarVM(baseDate: Date())
		let sut = HPCalendarView(frame: .zero, viewModel: vm)
		return (sut, vm)
	}
	
	class MockHPCalendarVM: HPCalendarViewModel {
		var baseDate: Date
		
		var days: [HPDay]
		
		init(baseDate: Date, days: [HPDay] = Array(repeating: HPDay(date: Date(), number: "1", isWithInMonth: true), count: 35)) {
			self.baseDate = baseDate
			self.days = days
		}
	}
	
	var numbersOfCalendarCell = 35
}
