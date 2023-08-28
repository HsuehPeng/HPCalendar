//
//  HPCalendar.swift
//  HPCalendar
//
//  Created by Hsueh Peng Tseng on 2023/8/21.
//

import Foundation

public protocol HPRangeCalendarDelegate: AnyObject {
	func calendar(didSelectDateRange range: (startDate: Date?, endDate: Date?))
}

public protocol HPSingleCalendarDelegate: AnyObject {
	func calendar(didSelectDate date : Date?)
}

public final class HPCalendar {
	public weak var singleDelegate: HPSingleCalendarDelegate?
	public weak var rangeDelegate: HPRangeCalendarDelegate?
	
	public enum CalendarType {
		case singleSelection
		case rangeSelection
	}
	
	public func makeCalendar(frame: CGRect, calendarType: CalendarType) -> HPCalendarView {
		switch calendarType {
		case .singleSelection:
			return makeSingleCalendar(frame: frame)
		case .rangeSelection:
			return makeRangeCalendar(frame: frame)
		}
	}
	
	private func makeSingleCalendar(frame: CGRect) -> HPCalendarView {
		let calendar = Calendar.current
		let metaDataProvider = MetaDataProvider(calendar: calendar)
		let hpdayLoader = NativeHPDayLoader(calendar: calendar, metaDataProvider: metaDataProvider)
		
		let calendarManager = HPSingleSelectionManager(calendar: calendar, dayLoader: hpdayLoader, headerTextFormate: "MMMM yyyy")
		
		let viewModel = HPCalendarViewModel(calendarManager: calendarManager)
		let calendarView = HPCalendarView(frame: frame, viewModel: viewModel)
		
		calendarManager.onSelectedDate = { [weak self] date in
			guard let self = self else { return }
			self.singleDelegate?.calendar(didSelectDate: date)
		}
		
		calendarManager.onReloadCalendar = { [viewModel] in
			viewModel.days = calendarManager.loadDays()
		}
		return calendarView
	}
	
	private func makeRangeCalendar(frame: CGRect) -> HPCalendarView {
		let calendar = Calendar.current
		let metaDataProvider = MetaDataProvider(calendar: calendar)
		let hpdayLoader = NativeHPDayLoader(calendar: calendar, metaDataProvider: metaDataProvider)

		let calendarManager = HPRangeSelectionManager(calendar: calendar, dayLoader: hpdayLoader, headerTextFormate: "MMMM yyyy")

		let viewModel = HPCalendarViewModel(calendarManager: calendarManager)
		let calendarView = HPCalendarView(frame: frame, viewModel: viewModel)

		calendarManager.onSelectedDate = { [weak self] startDate, endDate in
			guard let self = self else { return }
			self.rangeDelegate?.calendar(didSelectDateRange: (startDate, endDate))
		}

		calendarManager.onReloadCalendar = { [viewModel] in
			viewModel.days = calendarManager.loadDays()
		}
		return calendarView
	}
	
	public init() {}
}
