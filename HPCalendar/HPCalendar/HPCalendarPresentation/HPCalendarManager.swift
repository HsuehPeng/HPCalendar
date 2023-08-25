//
//  HPCalendarManager.swift
//  HPCalendar
//
//  Created by Hsueh Peng Tseng on 2023/8/25.
//

protocol HPCalendarManager {
	func loadDays() -> [HPSelectionDay]
	
	func calendarHeaderText() -> String
	
	func setNextBaseDate()
	
	func setPreviousBaseDate()
	
	func setSelectedDate(_ date: Date)
}
