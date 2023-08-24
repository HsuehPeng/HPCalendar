//
//  HPCalendarViewModel.swift
//  HPCalendar
//
//  Created by Hsueh Peng Tseng on 2023/8/17.
//

class HPCalendarViewModel {
	private let calendarManager: HPCalendarManager
	
	var days: [HPSelectionDay] {
		didSet {
			onReload?()
		}
	}
	
	var onReload: (() -> Void)?
	
	var headerText: String {
		return calendarManager.calendarHeaderText()
	}
	
	func setNextBaseDate() {
		calendarManager.setNextBaseDate()
	}
	
	func setPreviousBaseDate() {
		calendarManager.setPreviousBaseDate()
	}
	
	func selectedDate(at index: Int) {
		let date = days[index].date
		calendarManager.setSelectedDate(date)
		
		onReload?()
	}
	
	init(calendarManager: HPCalendarManager) {
		self.calendarManager = calendarManager
		self.days = calendarManager.loadDays()
	}
}
