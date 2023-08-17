//
//  HPCalendarViewModel.swift
//  HPCalendar
//
//  Created by Hsueh Peng Tseng on 2023/8/17.
//

protocol HPCalendarViewModel {
	var baseDate: Date { get set }
	var days: [HPDay] { get set }
	var headerText: String { get }
	var onSetHeaderText: ((String) -> Void)? { get set }
	
	func setNextBaseDate()
	func setPreviousBaseDate()
}

class HPSingleCalendarViewModel: HPCalendarViewModel {
	private let dataSource: CalendarDataSource
	private let dateFormater: DateFormatter
	private let calendar: Calendar
	
	var baseDate: Date {
		didSet {
			days = dataSource.generateDaysInMonth(for: baseDate)
			onSetHeaderText?(headerText)
		}
	}
	
	var days: [HPDay]
	
	var onSetHeaderText: ((String) -> Void)?
	
	var headerText: String {
		return dateFormater.string(from: baseDate)
	}
	
	func setNextBaseDate() {
		baseDate = calendar.date(byAdding: .month, value: 1, to: baseDate) ?? baseDate
	}
	
	func setPreviousBaseDate() {
		baseDate = calendar.date(byAdding: .month, value: -1, to: baseDate) ?? baseDate
	}
	
	init(dataSource: CalendarDataSource, baseDate: Date = Date(), dateFormater: DateFormatter, calendar: Calendar) {
		self.dataSource = dataSource
		self.baseDate = baseDate
		self.dateFormater = dateFormater
		self.calendar = calendar
		self.days = dataSource.generateDaysInMonth(for: baseDate)
	}
}
