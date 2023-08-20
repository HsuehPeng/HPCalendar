//
//  SharedTestHelpers.swift
//  HPCalendarTests
//
//  Created by Hsueh Peng Tseng on 2023/8/18.
//

import Foundation

func makeTestCalendar() -> Calendar {
	var calendar = Calendar(identifier: .gregorian)
	calendar.timeZone = .gmt
	return calendar
}
