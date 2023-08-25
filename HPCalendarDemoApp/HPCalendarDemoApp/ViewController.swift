//
//  ViewController.swift
//  HPCalendarDemoApp
//
//  Created by Hsueh Peng Tseng on 2023/8/21.
//

import UIKit
import HPCalendar

class ViewController: UIViewController, HPSingleCalendarDelegate, HPRangeCalendarDelegate {
	func calendar(didSelectDateRange range: (startDate: Date?, endDate: Date?)) {
		print(range)
	}

	func calendar(didSelectDate date: Date?) {
		print(date)
	}
	
	let calendar = HPCalendar()
	
	lazy var calendarView = calendar.makeCalendar(frame: CGRect(x: 0, y: 200, width: view.frame.width - 50, height: view.frame.height / 2.5), calendarType: .range)

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		calendar.singleDelegate = self
		calendar.rangeDelegate = self
		
		view.addSubview(calendarView)
	}


}

