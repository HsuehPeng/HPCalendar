//
//  HPCalendarViewModel.swift
//  HPCalendar
//
//  Created by Hsueh Peng Tseng on 2023/8/17.
//

protocol HPCalendarViewModel {
	var baseDate: Date { get set }
	var days: [HPDay] { get set }
	
	func headerText() -> String
}

class HPSingleCalendarViewModel: HPCalendarViewModel {
	private let dataSource: CalendarDataSource
	private let dateFormater: DateFormatter
	
	var baseDate: Date {
		didSet {
			days = dataSource.generateDaysInMonth(for: baseDate)
		}
	}
	
	var days: [HPDay]
	
	func headerText() -> String {
		return dateFormater.string(from: baseDate)
	}
	
	init(dataSource: CalendarDataSource, baseDate: Date = Date(), dateFormater: DateFormatter) {
		self.dataSource = dataSource
		self.baseDate = baseDate
		self.dateFormater = dateFormater
		self.days = dataSource.generateDaysInMonth(for: baseDate)
	}
}
