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
	
	let dateLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
}
