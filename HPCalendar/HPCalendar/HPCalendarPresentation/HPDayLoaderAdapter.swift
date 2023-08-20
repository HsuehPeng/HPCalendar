//
//  HPDayLoaderAdapter.swift
//  HPCalendar
//
//  Created by Hsueh Peng Tseng on 2023/8/20.
//

import Foundation

class HPDayLoaderAdapter<T> {
	private let adaptee: HPDayLoader
	private let mapHPDays: (HPDay) -> T
	
	func load(for date: Date) -> [T] {
		return adaptee.generateHPDaysInMonth(for: date).map(mapHPDays)
	}
	
	init(adaptee: HPDayLoader, mapHPDays: @escaping (HPDay) -> T) {
		self.adaptee = adaptee
		self.mapHPDays = mapHPDays
	}
	
}
