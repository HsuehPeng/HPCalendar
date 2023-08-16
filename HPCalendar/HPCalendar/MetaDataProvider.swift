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
	
}
