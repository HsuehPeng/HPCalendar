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
				isToday: isSameDay(date1: Date(), date2: hpday.date, with: calendar),
				isSelected: isInSelectedDateRange(for: hpday.date),
				hasEvent: events.contains { isSameDay(date1: $0.date, date2: hpday.date, with: calendar) }
			)
		}
	}
	
	func calendarHeaderText() -> String {
		return transformToFormattedDate(from: baseDate, by: headerTextFormate)
	}
	
	func setNextBaseDate() {
		baseDate = addTimeUnit(byAdding: .month, to: baseDate, with: calendar)
	}
	
	func setPreviousBaseDate() {
		baseDate = minusTimeUnit(byminusing: .month, to: baseDate, with: calendar)
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
			selectedDate.endDate = getFirstSecondOfDate(from: date, with: calendar)
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
