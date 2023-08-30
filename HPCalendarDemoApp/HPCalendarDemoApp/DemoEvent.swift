//
//  DemoEvent.swift
//  HPCalendarDemoApp
//
//  Created by Hsueh Peng Tseng on 2023/8/30.
//

import Foundation
import HPCalendar

struct DemoEvent: HPEvent {
	let title: String
	let date: Date
	let duration: Int
}
