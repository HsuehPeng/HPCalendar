//
//  HPCalendar.swift
//  HPCalendar
//
//  Created by Hsueh Peng Tseng on 2023/8/21.
//

import Foundation

public protocol HPCalendarDelegate: AnyObject {
	func calendar(didSelectDate date : Date?)
	func calendar(didSelectDateRange range: (startDate: Date?, endDate: Date?))
}

public final class HPCalendar {
	
	public weak var delegate: HPCalendarDelegate?
	
	private enum CalendarType {
		case single
		case range
	}
	
	public func makeSingleCalendar(frame: CGRect) -> HPCalendarView {
		let calendar = Calendar.current
		let metaDataProvider = MetaDataProvider(calendar: calendar)
		let hpdayLoader = NativeHPDayLoader(calendar: calendar, metaDataProvider: metaDataProvider)
		
		let calendarManager = HPSingleSelectionManager(calendar: calendar, dayLoader: hpdayLoader, headerTextFormate: "MMMM yyyy")
		
		let viewModel = HPCalendarViewModel(calendarManager: calendarManager)
		let calendarView = HPCalendarView(frame: frame, viewModel: viewModel)
		
		calendarManager.onSelectedDate = { [weak self] date in
			guard let self = self else { return }
			self.delegate?.calendar(didSelectDate: date)
		}
		
		calendarManager.onReloadCalendar = { [viewModel] in
			viewModel.days = calendarManager.loadDays()
		}
		return calendarView
	}
	
	public func makeRangeCalendar(frame: CGRect) -> HPCalendarView {
		let calendar = Calendar.current
		let metaDataProvider = MetaDataProvider(calendar: calendar)
		let hpdayLoader = NativeHPDayLoader(calendar: calendar, metaDataProvider: metaDataProvider)

		let calendarManager = HPRangeSelectionManager(calendar: calendar, dayLoader: hpdayLoader, headerTextFormate: "MMMM yyyy")

		let viewModel = HPCalendarViewModel(calendarManager: calendarManager)
		let calendarView = HPCalendarView(frame: frame, viewModel: viewModel)

		calendarManager.onSelectedDate = { [weak self] startDate, endDate in
			guard let self = self else { return }
			self.delegate?.calendar(didSelectDateRange: (startDate, endDate))
		}

		calendarManager.onReloadCalendar = { [viewModel] in
			viewModel.days = calendarManager.loadDays()
		}
		return calendarView
	}
	
	public init() {}
}
