//
//  File.swift
//  HPCalendar
//
//  Created by Hsueh Peng Tseng on 2023/8/24.
//

protocol HPCalendarCellViewModel {
	var dateNumber: String { get }
	var dateTextColor: RGBColor { get }
	var isSelectionViewHidden: Bool { get }
}
