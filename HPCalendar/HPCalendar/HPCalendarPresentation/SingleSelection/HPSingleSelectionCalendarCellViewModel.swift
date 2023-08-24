//
//  HPSingleSelectionCalendarCellViewModel.swift
//  HPCalendar
//
//  Created by Hsueh Peng Tseng on 2023/8/24.
//

import Foundation

class HPSingleSelectionCalendarCellViewModel: HPCalendarCellViewModel {
	let day: HPSingleSelectionDay
	
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
		
		if day.isSelected {
			rgbColor = HPCalendarCellUIConfiguration.selectedTextColor
		}
		
		return rgbColor
	}
	
	var isSelectionViewHidden: Bool {
		return !day.isSelected
	}
	
	init(day: HPSingleSelectionDay) {
		self.day = day
	}
}
