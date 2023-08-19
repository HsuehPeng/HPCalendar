//
//  HPCalendarManager.swift
//  HPCalendar
//
//  Created by Hsueh Peng Tseng on 2023/8/18.
//

class HPCalendarManager {
	private let calendar: Calendar
	
	func addTimeUnit(with component: Calendar.Component, to date: Date) -> Date {
		return calendar.date(byAdding: component, value: 1, to: date) ?? date
	}
	
	func minusTimeUnit(with component: Calendar.Component, to date: Date) -> Date {
		return calendar.date(byAdding: component, value: -1, to: date) ?? date
	}
	
	func transformToFormattedDate(from date: Date, by formate: String) -> String {
		let formatter = DateFormatter()
		formatter.dateFormat = formate
		return formatter.string(from: date)
	}
	
	func getFirstSecondOfDate(from date: Date) -> Date {
		let dayComponents = calendar.dateComponents([.year, .month, .day], from: date)
		return calendar.date(from: dayComponents) ?? date
	}
	
	init(calendar: Calendar) {
		self.calendar = calendar
	}
}
