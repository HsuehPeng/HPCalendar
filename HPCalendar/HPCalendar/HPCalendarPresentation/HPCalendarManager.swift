//
//  HPCalendarManager.swift
//  HPCalendar
//
//  Created by Hsueh Peng Tseng on 2023/8/25.
//

protocol HPCalendarManager {
	func loadDays() -> [HPSelectionDay]
	
	func calendarHeaderText() -> String
	
	func setNextBaseDate()
	
	func setPreviousBaseDate()
	
	func setSelectedDate(_ date: Date)
}

extension HPCalendarManager {
	func addTimeUnit(byAdding component: Calendar.Component, to date: Date, with calendar: Calendar) -> Date {
		return calendar.date(byAdding: component, value: 1, to: date) ?? date
	}
	
	func minusTimeUnit(byMinusing component: Calendar.Component, to date: Date, with calendar: Calendar) -> Date {
		return calendar.date(byAdding: component, value: -1, to: date) ?? date
	}
	
	func transformToFormattedDate(from date: Date, by formate: String) -> String {
		let formatter = DateFormatter()
		formatter.dateFormat = formate
		return formatter.string(from: date)
	}
	
	func getFirstSecondOfDate(for date: Date, with calendar: Calendar) -> Date {
		let dayComponents = calendar.dateComponents([.year, .month, .day], from: date)
		return calendar.date(from: dayComponents) ?? date
	}
	
	func getLastSecondOfDay(for date: Date, with calendar: Calendar) -> Date {
		var components = calendar.dateComponents([.year, .month, .day], from: date)
		components.hour = 23
		components.minute = 59
		components.second = 59
		
		return calendar.date(from: components) ?? date
	}
	
	func isSameDay(date1: Date, date2: Date, with calendar: Calendar) -> Bool {
		let components1 = calendar.dateComponents([.year, .month, .day], from: date1)
		let components2 = calendar.dateComponents([.year, .month, .day], from: date2)
				
		return components1.year == components2.year &&
			   components1.month == components2.month &&
			   components1.day == components2.day
	}
}
