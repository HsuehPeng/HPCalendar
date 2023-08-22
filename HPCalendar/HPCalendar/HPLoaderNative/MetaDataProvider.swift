//
//  MetaDataProvider.swift
//  HPCalendar
//
//  Created by Hsueh Peng Tseng on 2023/8/16.
//

class MetaDataProvider {
	private let calendar: Calendar
	
	init(calendar: Calendar) {
		self.calendar = calendar
	}
	
	var numbersOfDaysShownInPage: Int {
		return HPCalendarPolicy.numbersOfCell
	}
	
	func getFirstDateOfMonth(for date: Date) -> Date {
		let components = calendar.dateComponents([.year, .month], from: date)
		return calendar.date(from: components) ?? date
	}
	
	func firstDateOffSet(for date: Date) -> Int {
		let firstDateOfMonth = getFirstDateOfMonth(for: date)
		return calendar.component(.weekday, from: firstDateOfMonth)
	}
	
	func getLastDateOfMonth(for date: Date) -> Date {
		let lastDayInMonth = calendar.date(byAdding: DateComponents(month: 1, day: -1), to: getFirstDateOfMonth(for: date))
		return lastDayInMonth ?? date
	}
	
	func numbersOfDaysInMonth(for date: Date) -> Int {
		guard let numbersOfDaysRange = calendar.range(of: .day, in: .month, for: date) else { return 0 }
		return numbersOfDaysRange.count
	}
	
}
