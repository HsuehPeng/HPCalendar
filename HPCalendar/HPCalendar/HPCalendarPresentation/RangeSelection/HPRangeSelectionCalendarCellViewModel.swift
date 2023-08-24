//
//  HPRangeSelectionCalendarCellViewModel.swift
//  HPCalendar
//
//  Created by Hsueh Peng Tseng on 2023/8/24.
//

class HPRangeSelectionCalendarCellViewModel: HPCalendarCellViewModel {
	let day: HPRangeSelectionDay
	
	var dateNumber: String {
		return day.number
	}
	
	var dateTextColor: RGBColor {
		var rgbColor: RGBColor
		
		if day.isWithInMonth {
			rgbColor = HPCalendarCellUIConfiguration.withinMonthTextColor
		} else {
			rgbColor = HPCalendarCellUIConfiguration.notWithinMonthTextColor
		}
		
		if day.isToday {
			rgbColor = HPCalendarCellUIConfiguration.todayTextColor
		}
		
		if day.isInRange {
			rgbColor = HPCalendarCellUIConfiguration.selectedTextColor
		}
		
		return rgbColor
	}
	
	var isSelectionViewHidden: Bool {
		return !day.isInRange
	}
	
	
	init(day: HPRangeSelectionDay) {
		self.day = day
	}
	
}
