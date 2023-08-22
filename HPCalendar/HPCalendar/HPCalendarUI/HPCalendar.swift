//
//  HPCalendar.swift
//  HPCalendar
//
//  Created by Hsueh Peng Tseng on 2023/8/21.
//

import Foundation

public protocol HPCalendarDelegate: AnyObject {
	func calendar(_ calendar : HPCalendar, didSelectDate date : Date?)
}

public final class HPCalendar {
	
	public weak var delegate: HPCalendarDelegate?
	
	public func make(frame: CGRect) -> HPSingleSelectionCalendarView {
		let calendar = Calendar.current
		let metaDataProvider = MetaDataProvider(calendar: calendar)
		let hpdayLoader = NativeHPDayLoader(calendar: calendar, metaDataProvider: metaDataProvider)
		let calendarManager = HPCalendarManager(calendar: calendar)
		calendarManager.onSelectedDate = { [weak self] date in
			guard let self = self else { return }
			delegate?.calendar(self, didSelectDate: date)
		}
		let hpdayLoaderAdapter = HPDayLoaderAdapter<HPSingleSelectionDay>(adaptee: hpdayLoader) { [calendarManager] hpday in
			let today = Date()
			return HPSingleSelectionDay(date: hpday.date,
										number: hpday.number,
										isWithInMonth: hpday.isWithInMonth,
										isToday: calendarManager.getFirstSecondOfDate(from: today) == hpday.date,
										isSelected: calendarManager.selectedDate == hpday.date
			)
		}
		let viewModel = HPSingleCalendarViewModel(dayLoader: hpdayLoaderAdapter, calendarManager: calendarManager, headerTextFormate: "MMMM yyyy")
		return HPSingleSelectionCalendarView(frame: frame, viewModel: viewModel)
	}
	
	public init() {}
}
