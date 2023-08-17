//
//  CalendarDataSource.swift
//  HPCalendar
//
//  Created by Hsueh Peng Tseng on 2023/8/16.
//

import Foundation

class CalendarDataSource {
	private let metaDataProvider: MetaDataProvider
	private let calendar: Calendar
	
	init(calendar: Calendar) {
		self.metaDataProvider = MetaDataProvider(calendar: calendar)
		self.calendar = calendar
	}
	
	func generateDaysInMonth(for date: Date) -> [HPDay] {
		let numberOfDaysInMonth = metaDataProvider.numbersOfDaysInMonth(for: date)
		let firstDateOfMonth = metaDataProvider.getFirstDateOfMonth(for: date)
		let lastDateOfMonth = metaDataProvider.getLastDateOfMonth(for: date)
		
		let days = (1...numberOfDaysInMonth).map { day in
			let dayOffset = day - 1
			
			let date = calendar.date(byAdding: .day, value: dayOffset, to: firstDateOfMonth) ?? firstDateOfMonth
			return generateDay(for: date, isWithinMonth: true)
		}
		
		return generatePreviousMonthDay(by: firstDateOfMonth) + days + generateNextMonthDay(by: lastDateOfMonth)
	}
	
	private func generatePreviousMonthDay(by date: Date) -> [HPDay] {
		let initialOffset = metaDataProvider.firstDateOffSet(for: date)
		var days: [HPDay] = []
		
		for i in (1...initialOffset-1).reversed() {
			let previousDate = calendar.date(byAdding: .day, value: -i, to: date) ?? date
			days.append(generateDay(for: previousDate, isWithinMonth: false))
		}
		
		return days
	}
	
	private func generateNextMonthDay(by date: Date) -> [HPDay] {
		let additionalDays = metaDataProvider.nextMonthWeekDayOffSet(for: date)
		
		guard additionalDays > 0 else { return [] }
		
		var days: [HPDay] = []
		
		for i in 1...additionalDays {
			let nextDate = calendar.date(byAdding: .day, value: i, to: date) ?? date
			days.append(generateDay(for: nextDate, isWithinMonth: false))
		}
		
		return days
	}
	
	private func generateDay(for date: Date, isWithinMonth: Bool) -> HPDay {
		let formatter = DateFormatter()
		formatter.dateFormat = "d"
		
		return HPDay(date: date, number: formatter.string(from: date), isWithInMonth: isWithinMonth)
	}
}
