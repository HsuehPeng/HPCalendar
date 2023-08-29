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
	
	var dateTextColor: RGBColor {
		var rgbColor: RGBColor
		
		if day.isWithInMonth {
			rgbColor = HPCalendarColorConstant.withinMonthTextColor
		} else {
			rgbColor = HPCalendarColorConstant.notWithinMonthTextColor
			return rgbColor
		}
		
		if day.isToday {
			rgbColor = HPCalendarColorConstant.todayTextColor
		}
		
		if day.isSelected {
			rgbColor = HPCalendarColorConstant.selectedTextColor
		}
		
		return rgbColor
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
