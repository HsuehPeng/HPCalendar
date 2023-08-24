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
			rgbColor = HPSingleSelectionCalendarUIConfiguration.withinMonthTextColor
		} else {
			rgbColor = HPSingleSelectionCalendarUIConfiguration.notWithinMonthTextColor
		}
		
		if day.isToday {
			rgbColor = HPSingleSelectionCalendarUIConfiguration.todayTextColor
		}
		
		if day.isInRange {
			rgbColor = HPSingleSelectionCalendarUIConfiguration.selectedTextColor
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
