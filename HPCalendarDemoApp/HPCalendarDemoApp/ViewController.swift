//
//  ViewController.swift
//  HPCalendarDemoApp
//
//  Created by Hsueh Peng Tseng on 2023/8/21.
//

import UIKit
import HPCalendar

class ViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		let calendar = HPCalendar()
		let calendarView = calendar.make(frame: CGRect(x: 0, y: 200, width: view.frame.width, height: view.frame.height / 2))
		view.addSubview(calendarView)
	}


}

