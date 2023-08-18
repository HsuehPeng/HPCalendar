//
//  HPCalendarViewModel.swift
//  HPCalendar
//
//  Created by Hsueh Peng Tseng on 2023/8/17.
//

class HPSingleCalendarViewModel {
	private let dayLoader: NativeHPDaysLoader
	private let dateFormater: DateFormatter
	private let calendar: Calendar
	
	var baseDate: Date {
		didSet {
			days = dayLoader.generateHPDaysInMonth(for: baseDate)
			onSetBaseDate?()
		}
	}
	
	var days: [HPDay]
	
	var onSetBaseDate: (() -> Void)?
	
	var headerText: String {
		return dateFormater.string(from: baseDate)
	}
	
	func setNextBaseDate() {
		baseDate = calendar.date(byAdding: .month, value: 1, to: baseDate) ?? baseDate
	}
	
	func setPreviousBaseDate() {
		baseDate = calendar.date(byAdding: .month, value: -1, to: baseDate) ?? baseDate
	}
	
	init(baseDate: Date = Date(), dateFormater: DateFormatter, calendar: Calendar) {
		self.dayLoader = NativeHPDaysLoader(calendar: calendar)
		self.baseDate = baseDate
		self.dateFormater = dateFormater
		self.calendar = calendar
		self.days = dayLoader.generateHPDaysInMonth(for: baseDate)
	}
}
