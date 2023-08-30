//
//  HPCalendarCell.swift
//  HPCalendar
//
//  Created by Hsueh Peng Tseng on 2023/8/17.
//

import UIKit

class HPCalendarCell: UICollectionViewCell {
	// MARK: - Properties
	
	static let reuseId = "\(HPCalendarCell.self)"
	
	let selectionView: UIView = {
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.backgroundColor = HPCalendarColorConstant.calendarCellSelectionColor.toUIColor()
		view.layer.cornerRadius = 8
		view.isHidden = true
		return view
	}()
	
	let dateLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.textAlignment = .center
		label.font = UIFont.systemFont(ofSize: 13)
		return label
	}()
	
	let eventDot: UIView = {
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.backgroundColor = HPCalendarColorConstant.eventDotColor.toUIColor()
		view.layer.cornerRadius = 2.5
		view.isHidden = true
		return view
	}()
	
	var viewModel: HPCalendarCellViewModel? {
		didSet {
			configureUI()
		}
	}
	
	// MARK: - LifeCycle
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupUI()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: - UI
	
	private func configureUI() {
		guard let viewModel = viewModel else { return }
		dateLabel.text = viewModel.dateNumber
		dateLabel.textColor = viewModel.dateTextColor.toUIColor()
		selectionView.isHidden = viewModel.isSelectionViewHidden
		eventDot.isHidden = viewModel.isEventDotHidden
	}
	
	private func setupUI() {
		contentView.addSubview(selectionView)
		contentView.addSubview(dateLabel)
		contentView.addSubview(eventDot)
		
		NSLayoutConstraint.activate([
			selectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 6),
			selectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -6),
			selectionView.heightAnchor.constraint(equalTo: selectionView.widthAnchor, multiplier: 1),
			selectionView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
		])
		
		NSLayoutConstraint.activate([
			dateLabel.centerXAnchor.constraint(equalTo: selectionView.centerXAnchor),
			dateLabel.centerYAnchor.constraint(equalTo: selectionView.centerYAnchor),
		])
		
		NSLayoutConstraint.activate([
			eventDot.centerXAnchor.constraint(equalTo: dateLabel.centerXAnchor),
//			eventDot.topAnchor.constraint(greaterThanOrEqualTo: selectionView.topAnchor),
			eventDot.bottomAnchor.constraint(equalTo: dateLabel.topAnchor, constant: -2),
			eventDot.widthAnchor.constraint(equalToConstant: 5),
			eventDot.heightAnchor.constraint(equalToConstant: 5)
		])
	}
	
}
