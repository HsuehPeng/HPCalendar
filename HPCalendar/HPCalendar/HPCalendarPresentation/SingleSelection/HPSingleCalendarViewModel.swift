//
//  HPCalendarViewModel.swift
//  HPCalendar
//
//  Created by Hsueh Peng Tseng on 2023/8/17.
//

class HPSingleCalendarViewModel {
	private let dayLoader: HPDayLoaderAdapter<HPSingleSelectionDay>
	private let calendarManager: HPCalendarManager
	private let headerTextFormate: String

	var baseDate: Date {
		didSet {
			days = dayLoader.load(for: baseDate)
			onSetBaseDate?()
		}
	}
	
	var days: [HPSingleSelectionDay]
	
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
	
	init(baseDate: Date = Date(), dayLoader: HPDayLoaderAdapter<HPSingleSelectionDay>, calendarManager: HPCalendarManager, headerTextFormate: String) {
		self.baseDate = baseDate
		self.dayLoader = dayLoader
		self.calendarManager = calendarManager
		self.headerTextFormate = headerTextFormate
		self.days = dayLoader.load(for: baseDate)
	}
}
