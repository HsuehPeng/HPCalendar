//
//  HPCalendar.swift
//  HPCalendar
//
//  Created by Hsueh Peng Tseng on 2023/8/21.
//

import Foundation

public final class HPCalendar {
	public func make(frame: CGRect) -> HPSingleSelectionCalendarView {
		let calendar = Calendar.current
		let metaDataProvider = MetaDataProvider(calendar: calendar)
		let hpdayLoader = NativeHPDayLoader(calendar: calendar, metaDataProvider: metaDataProvider)
		let calendarManager = HPCalendarManager(calendar: calendar)
		let hpdayLoaderAdapter = HPDayLoaderAdapter<HPSingleSelectionDay>(adaptee: hpdayLoader) { hpday in
			let today = Date()
			return HPSingleSelectionDay(date: hpday.date,
										number: hpday.number,
										isWithInMonth: hpday.isWithInMonth,
										isToday: calendarManager.getFirstSecondOfDate(from: today) == hpday.date
			)
		}
		let viewModel = HPSingleCalendarViewModel(dayLoader: hpdayLoaderAdapter, calendarManager: calendarManager, headerTextFormate: "MMMM yyyy")
		return HPSingleSelectionCalendarView(frame: frame, viewModel: viewModel)
	}
	
	public init() {}
}
