//
//  DemoEventView.swift
//  HPCalendarDemoApp
//
//  Created by Hsueh Peng Tseng on 2023/9/1.
//

import UIKit

class SelectionInfoView: UIView {
	let dateLabel: UILabel = {
		let label = UILabel()
		label.font = UIFont.systemFont(ofSize: 13)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	let eventCountLabel: UILabel = {
		let label = UILabel()
		label.font = UIFont.systemFont(ofSize: 13)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		backgroundColor = .lightGray
		setupUI()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func setupUI() {
		self.addSubview(dateLabel)
		self.addSubview(eventCountLabel)

		NSLayoutConstraint.activate([
			dateLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 4),
			dateLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
			dateLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
		])
		
		NSLayoutConstraint.activate([
			eventCountLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 4),
			eventCountLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
			eventCountLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
			eventCountLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -4)
		])
		
	}
	
}
