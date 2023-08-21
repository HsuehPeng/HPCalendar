//
//  HPCalendarCell.swift
//  HPCalendar
//
//  Created by Hsueh Peng Tseng on 2023/8/17.
//

import UIKit

class HPSingleSelectionCalendarCell: UICollectionViewCell {
	// MARK: - Properties
	
	static let reuseId = "\(HPSingleSelectionCalendarCell.self)"
	
	let selectionView: UIView = {
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.backgroundColor = .clear
		return view
	}()
	
	let dateLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	// MARK: - LifeCycle
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		setupUI()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: - UI
	
	private func setupUI() {
		contentView.addSubview(selectionView)
		contentView.addSubview(dateLabel)
		
		NSLayoutConstraint.activate([
			selectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
			selectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
			selectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
			selectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
		])
		
		NSLayoutConstraint.activate([
			dateLabel.centerXAnchor.constraint(equalTo: selectionView.centerXAnchor),
			dateLabel.centerYAnchor.constraint(equalTo: selectionView.centerYAnchor),
			dateLabel.widthAnchor.constraint(equalTo: selectionView.widthAnchor, multiplier: 0.6),
			dateLabel.heightAnchor.constraint(equalTo: selectionView.heightAnchor, multiplier: 0.6)
		])
	}
	
}
