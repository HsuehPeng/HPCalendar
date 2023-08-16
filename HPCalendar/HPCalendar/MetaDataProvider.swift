//
//  MetaDataProvider.swift
//  HPCalendar
//
//  Created by Hsueh Peng Tseng on 2023/8/16.
//

public class MetaDataProvider {
	private let calendar: Calendar
	
	public init(calendar: Calendar) {
		self.calendar = calendar
	}
	
	public func getFirstDateOfMonth(for date: Date) -> Date {
		let components = calendar.dateComponents([.year, .month], from: date)
		return calendar.date(from: components) ?? date
	}
	
	public func numbersOfDaysInMonth(for date: Date) -> Int {
		guard let numbersOfDaysRange = calendar.range(of: .day, in: .month, for: date) else { return 0 }
		return numbersOfDaysRange.count
	}
	
	public func firstDateOffSet(for date: Date) -> Int {
		let firstDateOfMonth = getFirstDateOfMonth(for: date)
		return calendar.component(.weekday, from: firstDateOfMonth)
	}
	
	public func nextMonthWeekDayOffSet(for date: Date) -> Int {
		guard let lastDayInMonth = calendar.date(byAdding: DateComponents(month: 1, day: -1), to: getFirstDateOfMonth(for: date)) else {
			return 0
		}
		
		let additionalDays = 7 - calendar.component(.weekday, from: lastDayInMonth)
		guard additionalDays > 0 else { return 0 }
		
		return additionalDays
	}
	
}
