//
//  ViewController.swift
//  HPCalendarDemoApp
//
//  Created by Hsueh Peng Tseng on 2023/8/21.
//

import UIKit
import HPCalendar

class SingleSelectionCalendarViewController: UIViewController, HPSingleCalendarDelegate {
	let hpcalendar: HPCalendar = {
		var calendar = Calendar(identifier: .gregorian)
		calendar.locale = Locale(identifier: "en_US")
		calendar.timeZone = .gmt
		let hpCalendar = HPCalendar(calendar: calendar)
		return hpCalendar
	}()
	
	lazy var calendarView = hpcalendar.makeCalendar(frame: .zero, calendarType: .singleSelection, with: [
		DemoEvent(title: "First", date: Date(), duration: 1),
		DemoEvent(title: "Second", date: Date().addingTimeInterval(1), duration: 1),
		DemoEvent(title: "Third", date: Date().addingTimeInterval(86400), duration: 2),
		DemoEvent(title: "Fourth", date: Date().addingTimeInterval(604800), duration: 3),
		DemoEvent(title: "Fifth", date: Date().addingTimeInterval(2629743), duration: 4),
		DemoEvent(title: "Sixth", date: Date().addingTimeInterval(2829743), duration: 5),
	])
	
	private let selectionInfoView: SelectionInfoView = {
		let view = SelectionInfoView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.dateLabel.text = "Date: "
		view.eventCountLabel.text = "Events Count: "
		return view
	}()
	
	private var dateFormatter: DateFormatter {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "MM-dd-yyyy HH:mm"
		dateFormatter.timeZone = .gmt
		return dateFormatter
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
				
		view.backgroundColor = UIColor(red: 0.98, green: 0.95, blue: 0.89, alpha: 1.00)
		hpcalendar.singleDelegate = self
		setupUI()
	}
	
	private func setupUI() {
		view.addSubview(calendarView)
		view.addSubview(selectionInfoView)

		calendarView.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			calendarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
			calendarView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
			calendarView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
			calendarView.heightAnchor.constraint(equalToConstant: 350)
		])
		
		NSLayoutConstraint.activate([
			selectionInfoView.topAnchor.constraint(equalTo: calendarView.bottomAnchor, constant: 50),
			selectionInfoView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
			selectionInfoView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
		])
		
	}
	
	// MARK: - HPSingleCalendarDelegate
	
	func calendar(didSelectDate result: SingleSelectionResult) {
		print(result)
		
		if let date = result.date {
			selectionInfoView.dateLabel.text = "Date: \(dateFormatter.string(from: date))"
			selectionInfoView.eventCountLabel.text = "Events Count: \(result.events.count.description)"
		} else {
			selectionInfoView.dateLabel.text = "Date: nil"
			selectionInfoView.eventCountLabel.text = "Events Count: \(result.events.count.description)"
		}
	}
	
}

