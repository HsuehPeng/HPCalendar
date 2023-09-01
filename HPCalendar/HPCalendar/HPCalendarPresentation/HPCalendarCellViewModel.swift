//
//  HPRangeSelectionCalendarCellViewModel.swift
//  HPCalendar
//
//  Created by Hsueh Peng Tseng on 2023/8/24.
//

class HPCalendarCellViewModel {
	let day: HPSelectionDay
	
	var dateNumber: String {
		return day.number
	}
	
	enum DateTextColorState {
		case selected
		case today
		case notInMonth
		case inMonth
	}
	
	var dateTextColorState: DateTextColorState {
		var colorState: DateTextColorState
		
		if day.isWithInMonth {
			colorState = .inMonth
		} else {
			colorState = .notInMonth
			return colorState
		}
		
		if day.isToday {
			colorState = .today
		}
		
		if day.isSelected {
			colorState = .selected
		}
		
		return colorState
	}
	
	var isSelectionViewHidden: Bool {
		return !day.isSelected
	}
	
	var isEventDotHidden: Bool {
		return !day.hasEvent
	}
	
	init(day: HPSelectionDay) {
		self.day = day
	}
	
}
