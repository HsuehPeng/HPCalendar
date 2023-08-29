//
//  HPCalendar.swift
//  HPCalendar
//
//  Created by Hsueh Peng Tseng on 2023/8/21.
//

import UIKit

public protocol HPRangeCalendarDelegate: AnyObject {
	func calendar(didSelectDateRange result: RangeSelectionResult)
}

public protocol HPSingleCalendarDelegate: AnyObject {
	func calendar(didSelectDate result: SingleSelectionResult)
}

public final class HPCalendar {
	public weak var singleDelegate: HPSingleCalendarDelegate?
	public weak var rangeDelegate: HPRangeCalendarDelegate?
	
	public enum CalendarType {
		case singleSelection
		case rangeSelection
	}
	
	public func makeCalendar(frame: CGRect, calendarType: CalendarType, with events: [HPEvent] = []) -> HPCalendarView {
		switch calendarType {
		case .singleSelection:
			return makeSingleCalendar(frame: frame, with: events)
		case .rangeSelection:
			return makeRangeCalendar(frame: frame, with: events)
		}
	}
	
	public init() {}
}

extension HPCalendar {
	private func makeSingleCalendar(frame: CGRect, with events: [HPEvent]) -> HPCalendarView {
		let calendar = Calendar.current
		let metaDataProvider = MetaDataProvider(calendar: calendar)
		let hpdayLoader = NativeHPDayLoader(calendar: calendar, metaDataProvider: metaDataProvider)
		
		let calendarManager = HPSingleSelectionManager(calendar: calendar, dayLoader: hpdayLoader, headerTextFormate: "MMMM yyyy", events: events)
		
		let viewModel = HPCalendarViewModel(calendarManager: calendarManager, days: calendarManager.loadDays())
		let calendarView = HPCalendarView(frame: frame, viewModel: viewModel)
		
		calendarManager.onSelectedDate = { [weak self] result in
			guard let self = self else { return }
			self.singleDelegate?.calendar(didSelectDate: result)
		}
		
		calendarManager.onReloadCalendar = { [viewModel] in
			viewModel.days = calendarManager.loadDays()
		}
		return calendarView
	}
	
	private func makeRangeCalendar(frame: CGRect, with events: [HPEvent]) -> HPCalendarView {
		let calendar = Calendar.current
		let metaDataProvider = MetaDataProvider(calendar: calendar)
		let hpdayLoader = NativeHPDayLoader(calendar: calendar, metaDataProvider: metaDataProvider)

		let calendarManager = HPRangeSelectionManager(calendar: calendar, dayLoader: hpdayLoader, headerTextFormate: "MMMM yyyy", events: events)

		let viewModel = HPCalendarViewModel(calendarManager: calendarManager, days: calendarManager.loadDays())
		let calendarView = HPCalendarView(frame: frame, viewModel: viewModel)

		calendarManager.onSelectedDate = { [weak self] result in
			guard let self = self else { return }
			self.rangeDelegate?.calendar(didSelectDateRange: result)
		}

		calendarManager.onReloadCalendar = { [viewModel] in
			viewModel.days = calendarManager.loadDays()
		}
		return calendarView
	}
}
