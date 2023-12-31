//
//  HPCalendarManager.swift
//  HPCalendar
//
//  Created by Hsueh Peng Tseng on 2023/8/18.
//

class HPSingleSelectionManager: HPCalendarManager {
	private let calendar: Calendar
	private let dayLoader: HPDayLoader
	private let events: [HPEvent]
	
	var baseDate: Date = Date() {
		didSet {
			onReloadCalendar?()
		}
	}
		
	var onSelectedDate: ((SingleSelectionResult) -> Void)?
	var onReloadCalendar: (() -> Void)?
	
	var selectedDate: Date? {
		didSet {
			if let selectedDate = selectedDate {
				onSelectedDate?(SingleSelectionResult(
					date: selectedDate,
					events: events.filter({ isSameDay(date1: $0.date, date2: selectedDate, with: calendar) }).sorted(by: { $0.date < $1.date }))
				)
			} else {
				onSelectedDate?(SingleSelectionResult(date: nil, events: []))
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
				isSelected: selectedDate == hpday.date,
				hasEvent: events.contains { isSameDay(date1: $0.date, date2: hpday.date, with: calendar) }
			)
		}
	}
	
	func calendarHeaderText() -> String {
		return formattedHeaderText(calendar: calendar, date: baseDate)
	}
	
	func setNextBaseDate() {
		baseDate = addTimeUnit(byAdding: .month, to: baseDate, with: calendar)
	}
	
	func setPreviousBaseDate() {
		baseDate = minusTimeUnit(byMinusing: .month, to: baseDate, with: calendar)
	}
	
	func setSelectedDate(_ date: Date) {
		if selectedDate == date {
			selectedDate = nil
		} else {
			selectedDate = date
		}
	}
	
	init(calendar: Calendar, dayLoader: HPDayLoader, events: [HPEvent]) {
		self.calendar = calendar
		self.dayLoader = dayLoader
		self.events = events
	}
}
