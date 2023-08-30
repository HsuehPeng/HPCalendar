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
	
	var calendar: Calendar {
		var calendar = Calendar(identifier: .gregorian)
		calendar.locale = Locale(identifier: "en_US")
		calendar.timeZone = .gmt
		return calendar
	}
	
	lazy var hpcalendar = HPCalendar(calendar: calendar)
	
	lazy var calendarView = hpcalendar.makeCalendar(frame: .zero, calendarType: .rangeSelection, with: [
		DemoEvent(title: "", date: Date(), duration: 1),
		DemoEvent(title: "", date: Date().addingTimeInterval(86400), duration: 2),
		DemoEvent(title: "", date: Date().addingTimeInterval(604800), duration: 3),
		DemoEvent(title: "", date: Date().addingTimeInterval(2629743), duration: 4),
		DemoEvent(title: "", date: Date().addingTimeInterval(2829743), duration: 5),
	])

	override func viewDidLoad() {
		super.viewDidLoad()
		
		hpcalendar.singleDelegate = self
		hpcalendar.rangeDelegate = self
		setupUI()
	}
	
	private func setupUI() {
		view.addSubview(calendarView)
		calendarView.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			calendarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
			calendarView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
			calendarView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
			calendarView.heightAnchor.constraint(equalToConstant: 350)
		])
		
	}


}

