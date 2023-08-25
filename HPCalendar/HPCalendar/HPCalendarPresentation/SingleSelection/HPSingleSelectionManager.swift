//
//  HPCalendarManager.swift
//  HPCalendar
//
//  Created by Hsueh Peng Tseng on 2023/8/18.
//

class HPSingleSelectionManager: HPCalendarManager {
	private let calendar: Calendar
	private let dayLoader: HPDayLoader
	
	private var baseDate: Date = Date() {
		didSet {
			onReloadCalendar?()
		}
	}
	
	private let headerTextFormate: String
	
	var onSelectedDate: ((Date?) -> Void)?
	var onReloadCalendar: (() -> Void)?
	
	var selectedDate: Date? {
		didSet {
			onSelectedDate?(selectedDate)
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
				isSelected: selectedDate == hpday.date
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
