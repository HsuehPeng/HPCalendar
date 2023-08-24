//
//  HPRangeSelectionManager.swift
//  HPCalendar
//
//  Created by Hsueh Peng Tseng on 2023/8/23.
//

class HPRangeSelectionManager: HPCalendarManager {
	private let calendar: Calendar
	private let dayLoader: HPDayLoader
	
	private var baseDate: Date = Date() {
		didSet {
			onReloadCalendar?()
		}
	}
	
	private let headerTextFormate: String
	
	var onSelectedDate: ((Date?, Date?) -> Void)?
	var onReloadCalendar: (() -> Void)?
	
	var selectedDate: (startDate: Date?, endDate: Date?) {
		didSet {
			onSelectedDate?(selectedDate.startDate, selectedDate.endDate)
			onReloadCalendar?()
		}
	}
	
	func loadDays() -> [HPSelectionDay] {
		return dayLoader.generateHPDaysInMonth(for: baseDate).map { hpday in
			return HPSelectionDay(
				date: hpday.date,
				number: hpday.number,
				isWithInMonth: hpday.isWithInMonth,
				isToday: getFirstSecondOfDate(from: Date()) == hpday.date,
				isSelected: isInSelectedDateRange(for: hpday.date)
			)
		}
	}
	
	func calendarHeaderText() -> String {
		return transformToFormattedDate(from: baseDate, by: headerTextFormate)
	}
	
	func setNextBaseDate() {
		baseDate = addTimeUnit(with: .month, to: baseDate)
	}
	
	func setPreviousBaseDate() {
		baseDate = minusTimeUnit(with: .month, to: baseDate)
	}
	
	func setSelectedDate(_ date: Date) {
		let startDate = selectedDate.startDate
		let endDate = selectedDate.endDate
		
		if startDate == nil && endDate == nil {
			selectedDate.startDate = date
		} else if date == startDate {
			selectedDate.startDate = nil
			selectedDate.endDate = nil
		} else if let start = startDate, date < start {
			selectedDate.startDate = date
		} else {
			selectedDate.endDate = date
		}
		
		onReloadCalendar?()
	}
	
	private func isInSelectedDateRange(for date: Date) -> Bool {
		guard let startDate = selectedDate.startDate else { return false }
		
		if date == startDate {
			return true
		} else if let endDate = selectedDate.endDate, (date >= startDate && date <= endDate) {
			return true
		}
				
		return false
	}
	
	private func addTimeUnit(with component: Calendar.Component, to date: Date) -> Date {
		return calendar.date(byAdding: component, value: 1, to: date) ?? date
	}
	
	private func minusTimeUnit(with component: Calendar.Component, to date: Date) -> Date {
		return calendar.date(byAdding: component, value: -1, to: date) ?? date
	}
	
	private func transformToFormattedDate(from date: Date, by formate: String) -> String {
		let formatter = DateFormatter()
		formatter.dateFormat = formate
		return formatter.string(from: date)
	}
	
	private func getFirstSecondOfDate(from date: Date) -> Date {
		let dayComponents = calendar.dateComponents([.year, .month, .day], from: date)
		return calendar.date(from: dayComponents) ?? date
	}
	
	init(calendar: Calendar, dayLoader: HPDayLoader, headerTextFormate: String) {
		self.calendar = calendar
		self.dayLoader = dayLoader
		self.headerTextFormate = headerTextFormate
	}
}
