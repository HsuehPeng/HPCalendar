//
//  HPRangeSelectionDay.swift
//  HPCalendar
//
//  Created by Hsueh Peng Tseng on 2023/8/23.
//

import Foundation

struct HPSelectionDay: Equatable {
	let date: Date
	let number: String
	let isWithInMonth: Bool
	let isToday: Bool
	let isSelected: Bool
}
