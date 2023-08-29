//
//  ViewController.swift
//  HPCalendarDemoApp
//
//  Created by Hsueh Peng Tseng on 2023/8/21.
//

import UIKit
import HPCalendar

struct DemoEvent: HPEvent {
	let title: String
	let date: Date
	let duration: Int
}

class ViewController: UIViewController, HPSingleCalendarDelegate, HPRangeCalendarDelegate {
	func calendar(didSelectDate result: SingleSelectionResult) {
		print(result)
	}
	
	func calendar(didSelectDateRange result: RangeSelectionResult) {
		print(result)
	}
	
	let calendar = HPCalendar()
	
	lazy var calendarView = calendar.makeCalendar(frame: CGRect(x: 0, y: 200, width: 350, height: 320), calendarType: .rangeSelection, with: [
		DemoEvent(title: "", date: Date(), duration: 1),
		DemoEvent(title: "", date: Date().addingTimeInterval(86400), duration: 2),
		DemoEvent(title: "", date: Date().addingTimeInterval(604800), duration: 3),
		DemoEvent(title: "", date: Date().addingTimeInterval(2629743), duration: 4),
		DemoEvent(title: "", date: Date().addingTimeInterval(2829743), duration: 5),
	])

	override func viewDidLoad() {
		super.viewDidLoad()
		calendar.singleDelegate = self
		calendar.rangeDelegate = self
		view.addSubview(calendarView)
	}


}

