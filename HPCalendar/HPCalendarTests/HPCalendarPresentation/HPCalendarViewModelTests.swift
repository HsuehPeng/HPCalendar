//
//  HPCalendarViewModel.swift
//  HPCalendarTests
//
//  Created by Hsueh Peng Tseng on 2023/8/16.
//

import XCTest
@testable import HPCalendar

final class HPCalendarViewModelTests: XCTestCase {
	
	func test_init_renderCorrectHeaderText() {
		let (sut, manager) = makeSut()

		XCTAssertEqual(sut.headerText, manager.calendarHeaderText())
	}
	
	func test_setNextBaseDateTwice_hpCalendarManagerCallSetNextBaseDateCallCount() {
		let (sut, manager) = makeSut()
		
		sut.setNextBaseDate()
		sut.setNextBaseDate()
		
		XCTAssertEqual(manager.messages, [.setNextBaseDate, .setNextBaseDate])
	}
	
	func test_setPreviousBaseDate_hpCalendarManagerCallSetPreviousBaseDateCallCount() {
		let (sut, manager) = makeSut()
		
		sut.setPreviousBaseDate()
		sut.setPreviousBaseDate()

		XCTAssertEqual(manager.messages, [.setPreviousBaseDate, .setPreviousBaseDate])
	}
	
	func test_selectedDate_donNotIncreasehpCalendarManagerSetSelectedDateCallCountWhenSelectDateThatIsOutSideOfMonth() {
		let (sut, manager) = makeSut()
		
		sut.selectedDate(at: 0)

		XCTAssertEqual(manager.messages, [])
	}
	
	func test_selectedDate_hpCalendarManagerCallSetSelectedDateCallCount() {
		let (sut, manager) = makeSut()
		
		sut.selectedDate(at: 1)

		XCTAssertEqual(manager.messages, [.setSelectedDate, .onReload])
	}

	func test_onReload_onReloadCallCountWhenSetDaysAndSetSelectedDate() {
		let (sut, manager) = makeSut()

		sut.days.append(HPSelectionDay(date: Date(), number: "1", isWithInMonth: false, isToday: false, isSelected: false, hasEvent: false))
		sut.selectedDate(at: 1)

		XCTAssertEqual(manager.messages, [.onReload, .setSelectedDate, .onReload])
	}
	
	// MARK: - Helpers
	
	private func makeSut(file: StaticString = #filePath, line: UInt = #line) -> (HPCalendarViewModel, HPCalendarManagerSpy) {
		let calendarManager = HPCalendarManagerSpy()
		
		let viewModel = HPCalendarViewModel(calendarManager: calendarManager, days: calendarManager.loadDays())
		
		viewModel.onReload = { [calendarManager] in
			calendarManager.messages.append(.onReload)
		}
		
		trackForMemoryLeaks(calendarManager, file: file, line: line)
		trackForMemoryLeaks(viewModel, file: file, line: line)

		return (viewModel, calendarManager)
	}
	
	private class HPCalendarManagerSpy: HPCalendarManager {
		enum Message {
			case setNextBaseDate
			case setPreviousBaseDate
			case setSelectedDate
			case onReload
		}
		
		var messages: [Message] = []
		
		func loadDays() -> [HPSelectionDay] {
			return [HPSelectionDay(date: Date(), number: "0", isWithInMonth: false, isToday: false, isSelected: false, hasEvent: false),
					HPSelectionDay(date: Date(), number: "1", isWithInMonth: true, isToday: false, isSelected: false, hasEvent: false)
			]
		}
		
		func calendarHeaderText() -> String {
			return "Header"
		}
		
		func setNextBaseDate() {
			messages.append(.setNextBaseDate)
		}
		
		func setPreviousBaseDate() {
			messages.append(.setPreviousBaseDate)
		}
		
		func setSelectedDate(_ date: Date) {
			messages.append(.setSelectedDate)
		}
	}

}
