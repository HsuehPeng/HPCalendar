//
//  HPCalendarViewModel.swift
//  HPCalendarTests
//
//  Created by Hsueh Peng Tseng on 2023/8/16.
//

import XCTest

class HPCalendarViewModel {
	var baseDate: Date
	
	init(baseDate: Date = Date()) {
		self.baseDate = baseDate
	}
}

final class HPCalendarViewModelTests: XCTestCase {
	
	func test_init_setBaseDate() {
		let currentDate = Date()
		let sut = HPCalendarViewModel(baseDate: currentDate)
		
		XCTAssertEqual(sut.baseDate, currentDate)
	}
}
