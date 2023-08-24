//
//  HPRangeSelectionManager.swift
//  HPCalendar
//
//  Created by Hsueh Peng Tseng on 2023/8/23.
//

class HPRangeSelectionManager {
	private let calendar: Calendar
	
	var onSelectedDate: (((startDate: Date, endDate: Date)) -> Void)?
	var selectedDate: (startDate: Date?, endDate: Date?) {
		didSet {
			guard let startDate = selectedDate.startDate, let endDate = selectedDate.endDate else { return }
			onSelectedDate?((startDate, endDate))
		}
	}
	
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
	
	func isInSelectedRange(for date: Date) -> Bool {
		guard let startDate = selectedDate.startDate else { return false }
		
		if let endDate = selectedDate.endDate {
			return (startDate <= date && endDate >= date)
		} else {
			return date == startDate
		}
	}
	
	init(calendar: Calendar) {
		self.calendar = calendar
	}
}
