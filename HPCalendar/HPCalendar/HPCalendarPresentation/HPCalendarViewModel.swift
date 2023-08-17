//
//  HPCalendarViewModel.swift
//  HPCalendar
//
//  Created by Hsueh Peng Tseng on 2023/8/17.
//

class HPCalendarViewModel {
	private let dataSource: CalendarDataSource
	
	var baseDate: Date {
		didSet {
			days = dataSource.generateDaysInMonth(for: baseDate)
		}
	}
	
	var days: [HPDay]
	
	init(dataSource: CalendarDataSource, baseDate: Date = Date()) {
		self.dataSource = dataSource
		self.baseDate = baseDate
		self.days = dataSource.generateDaysInMonth(for: baseDate)
	}
}
