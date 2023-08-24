//
//  HPRangeCalendarViewModel.swift
//  HPCalendar
//
//  Created by Hsueh Peng Tseng on 2023/8/23.
//

class HPRangeCalendarViewModel {
	private let dayLoader: HPDayLoaderAdapter<HPRangeSelectionDay>
	private let calendarManager: HPRangeSelectionManager
	private let headerTextFormate: String

	var baseDate: Date = Date() {
		didSet {
			days = dayLoader.load(for: baseDate)
			onSetBaseDate?()
		}
	}
	
	var days: [HPRangeSelectionDay]
	
	var onSetBaseDate: (() -> Void)?
	
	var headerText: String {
		return calendarManager.transformToFormattedDate(from: baseDate, by: headerTextFormate)
	}
	
	func setNextBaseDate() {
		baseDate = calendarManager.addTimeUnit(with: .month, to: baseDate)
	}
	
	func setPreviousBaseDate() {
		baseDate = calendarManager.minusTimeUnit(with: .month, to: baseDate)
	}
	
	func setSelectedDate(_ date: Date) {
		let startDate = calendarManager.selectedDate.startDate
		let endDate = calendarManager.selectedDate.endDate
		
		if startDate == nil && endDate == nil {
			calendarManager.selectedDate.startDate = date
		} else if date == startDate {
			calendarManager.selectedDate.startDate = nil
			calendarManager.selectedDate.endDate = nil
		} else if date < startDate! {
			calendarManager.selectedDate.startDate = date
		} else {
			calendarManager.selectedDate.endDate = date
		}
		
		days = dayLoader.load(for: baseDate)
		onSetBaseDate?()
	}
	
	init(dayLoader: HPDayLoaderAdapter<HPRangeSelectionDay>, calendarManager: HPRangeSelectionManager, headerTextFormate: String) {
		self.dayLoader = dayLoader
		self.calendarManager = calendarManager
		self.headerTextFormate = headerTextFormate
		self.days = dayLoader.load(for: baseDate)
	}
}
