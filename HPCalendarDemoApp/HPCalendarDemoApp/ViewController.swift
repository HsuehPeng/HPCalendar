//
//  ViewController.swift
//  HPCalendarDemoApp
//
//  Created by Hsueh Peng Tseng on 2023/8/21.
//

import UIKit
import HPCalendar

class ViewController: UIViewController, HPCalendarDelegate {
	func calendar(_ calendar: HPCalendar, didSelectDate date: Date?) {
		print(date)
	}
	
	let calendar = HPCalendar()
	lazy var calendarView = calendar.make(frame: CGRect(x: 0, y: 200, width: view.frame.width - 50, height: view.frame.height / 2.5))

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		calendar.delegate = self
		view.addSubview(calendarView)
	}


}

