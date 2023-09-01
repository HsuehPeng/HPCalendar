//
//  File.swift
//  HPCalendarDemoApp
//
//  Created by Hsueh Peng Tseng on 2023/8/30.
//

import UIKit
import HPCalendar

class RangeSelectionCalendarViewController: UIViewController, HPRangeCalendarDelegate {
	let hpcalendar: HPCalendar = {
		var calendar = Calendar(identifier: .gregorian)
		calendar.locale = Locale(identifier: "en_US")
		calendar.timeZone = .gmt
		let hpCalendar = HPCalendar(calendar: calendar)
		return hpCalendar
	}()
	
	lazy var calendarView = hpcalendar.makeCalendar(frame: .zero, calendarType: .rangeSelection, with: [
		DemoEvent(title: "", date: Date(), duration: 1),
		DemoEvent(title: "", date: Date().addingTimeInterval(86400), duration: 2),
		DemoEvent(title: "", date: Date().addingTimeInterval(604800), duration: 3),
		DemoEvent(title: "", date: Date().addingTimeInterval(2629743), duration: 4),
		DemoEvent(title: "", date: Date().addingTimeInterval(2829743), duration: 5),
	])
	
	private let selectionInfoView: SelectionInfoView = {
		let view = SelectionInfoView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.dateLabel.text = "Date Range: "
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
				
		view.backgroundColor = .white
		hpcalendar.rangeDelegate = self
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
	
	// MARK: - HPRangeCalendarDelegate
	
	func calendar(didSelectDateRange result: RangeSelectionResult) {
		print(result)
		
		if let startDate = result.startDate, let endDate = result.endDate {
			selectionInfoView.dateLabel.text = "Date Range: \(dateFormatter.string(from: startDate)) ~ \(dateFormatter.string(from: endDate))"
			selectionInfoView.eventCountLabel.text = "Events Count: \(result.events.count.description)"
		} else {
			selectionInfoView.dateLabel.text = "Date Range: nil"
			selectionInfoView.eventCountLabel.text = "Events Count: \(result.events.count.description)"
		}
	}

}
