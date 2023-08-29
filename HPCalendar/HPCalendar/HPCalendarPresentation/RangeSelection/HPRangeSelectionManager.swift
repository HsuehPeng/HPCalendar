//
//  HPRangeSelectionManager.swift
//  HPCalendar
//
//  Created by Hsueh Peng Tseng on 2023/8/23.
//

class HPRangeSelectionManager: HPCalendarManager {
	private let calendar: Calendar
	private let dayLoader: HPDayLoader
	private let events: [HPEvent]
	
	var baseDate: Date = Date() {
		didSet {
			onReloadCalendar?()
		}
	}
	
	private let headerTextFormate: String
	
	var onSelectedDate: ((RangeSelectionResult) -> Void)?
	var onReloadCalendar: (() -> Void)?
	
	var selectedDate: (startDate: Date?, endDate: Date?) {
		didSet {
			if let startDate = selectedDate.startDate, let endDate = selectedDate.endDate {
				onSelectedDate?(RangeSelectionResult(
					startDate: startDate,
					endDate: endDate,
					events: events.filter({ $0.date >= startDate && $0.date <= endDate }).sorted(by: { $0.date < $1.date }))
				)
			} else {
				onSelectedDate?(RangeSelectionResult(startDate: selectedDate.startDate, endDate: selectedDate.endDate, events: []))
			}

			onReloadCalendar?()
		}
	}
	
	func loadDays() -> [HPSelectionDay] {
		return dayLoader.generateHPDaysInMonth(for: baseDate).map { hpday in
			return HPSelectionDay(
				date: hpday.date,
				number: hpday.number,
				isWithInMonth: hpday.isWithInMonth,
				isToday: getFirstSecondOfDate(from: Date()) == getFirstSecondOfDate(from: hpday.date),
				isSelected: isInSelectedDateRange(for: hpday.date),
				hasEvent: events.contains { isSameDay(date1: $0.date, date2: hpday.date) }
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
			selectedDate = (nil, nil)
		} else if let start = startDate, date < start {
			selectedDate.startDate = date
		} else {
			selectedDate.endDate = date
		}
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
	
	init(calendar: Calendar, dayLoader: HPDayLoader, headerTextFormate: String, events: [HPEvent]) {
		self.calendar = calendar
		self.dayLoader = dayLoader
		self.headerTextFormate = headerTextFormate
		self.events = events
	}
}

extension HPRangeSelectionManager {
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
	
	private func isSameDay(date1: Date, date2: Date) -> Bool {
		let components1 = calendar.dateComponents([.year, .month, .day], from: date1)
		let components2 = calendar.dateComponents([.year, .month, .day], from: date2)
				
		return components1.year == components2.year &&
			   components1.month == components2.month &&
			   components1.day == components2.day
	}
}
