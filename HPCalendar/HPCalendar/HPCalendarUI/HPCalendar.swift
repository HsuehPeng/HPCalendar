//
//  HPCalendar.swift
//  HPCalendar
//
//  Created by Hsueh Peng Tseng on 2023/8/21.
//

import Foundation

public protocol HPCalendarDelegate: AnyObject {
	func calendar(didSelectDate date : Date?)
	func calendar(didSelectDateRange range: (startDate: Date, endDate: Date))
}

public final class HPCalendar {
	
	public weak var delegate: HPCalendarDelegate?
	
	private enum CalendarType {
		case single
		case range
	}
	
	public func makeSingleCalendar(frame: CGRect) -> HPSingleSelectionCalendarView {
		let calendar = Calendar.current
		let metaDataProvider = MetaDataProvider(calendar: calendar)
		let hpdayLoader = NativeHPDayLoader(calendar: calendar, metaDataProvider: metaDataProvider)
		
		let calendarManager = HPSingleSelectionManager(calendar: calendar)
		calendarManager.onSelectedDate = { [weak self] date in
			guard let self = self else { return }
			delegate?.calendar(didSelectDate: date)
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
	
	public func makeRangeCalendar(frame: CGRect) -> HPRangeSelectionCalendarView {
		let calendar = Calendar.current
		let metaDataProvider = MetaDataProvider(calendar: calendar)
		let hpdayLoader = NativeHPDayLoader(calendar: calendar, metaDataProvider: metaDataProvider)
		
		let calendarManager = HPRangeSelectionManager(calendar: calendar)
		calendarManager.onSelectedDate = { [weak self] dateRange in
			guard let self = self else { return }
			delegate?.calendar(didSelectDateRange: dateRange)
		}
		
		let hpdayLoaderAdapter = HPDayLoaderAdapter<HPRangeSelectionDay>(adaptee: hpdayLoader) { [calendarManager] hpday in
			let today = Date()
			return HPRangeSelectionDay(date: hpday.date,
									   number: hpday.number,
									   isWithInMonth: hpday.isWithInMonth,
									   isToday: calendarManager.getFirstSecondOfDate(from: today) == hpday.date,
									   isInRange: calendarManager.isInSelectedRange(for: hpday.date)
			)
		}
		
		let viewModel = HPRangeCalendarViewModel(dayLoader: hpdayLoaderAdapter, calendarManager: calendarManager, headerTextFormate: "MMMM yyyy")
		return HPRangeSelectionCalendarView(frame: frame, viewModel: viewModel)
	}
	
	public init() {}
}
