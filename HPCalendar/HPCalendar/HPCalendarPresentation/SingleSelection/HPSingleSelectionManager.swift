//
//  HPCalendarManager.swift
//  HPCalendar
//
//  Created by Hsueh Peng Tseng on 2023/8/18.
//

public protocol HPEvent {
	var title: String { get }
	var date: Date { get }
}

public struct SingleSelectionResult {
	public let date: Date?
	public let events: [HPEvent]
}

public struct RangeSelectionResult {
	public let startDate: Date?
	public let endDate: Date?
	public let events: [HPEvent]
}

class HPSingleSelectionManager: HPCalendarManager {
	private let calendar: Calendar
	private let dayLoader: HPDayLoader
	private let events: [HPEvent]
	
	var baseDate: Date = Date() {
		didSet {
			onReloadCalendar?()
		}
	}
	
	private let headerTextFormate: String
	
	var onSelectedDate: ((SingleSelectionResult) -> Void)?
	var onReloadCalendar: (() -> Void)?
	
	var selectedDate: Date? {
		didSet {
			if let selectedDate = selectedDate {
				onSelectedDate?(SingleSelectionResult(
					date: selectedDate,
					events: events.filter({ isSameDay(date1: $0.date, date2: selectedDate) }).sorted(by: { $0.date < $1.date }))
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
				isToday: isSameDay(date1: Date(), date2: hpday.date),
				isSelected: selectedDate == hpday.date,
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
		if selectedDate == date {
			selectedDate = nil
		} else {
			selectedDate = date
		}
	}
	
	init(calendar: Calendar, dayLoader: HPDayLoader, headerTextFormate: String, events: [HPEvent]) {
		self.calendar = calendar
		self.dayLoader = dayLoader
		self.headerTextFormate = headerTextFormate
		self.events = events
	}
}

extension HPSingleSelectionManager {
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
