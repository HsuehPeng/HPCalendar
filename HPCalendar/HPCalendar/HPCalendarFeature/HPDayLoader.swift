//
//  HPDayLoader.swift
//  HPCalendar
//
//  Created by Hsueh Peng Tseng on 2023/8/18.
//

protocol HPDayLoader {
	func generateHPDaysInMonth(for date: Date) -> [HPDay]
}
