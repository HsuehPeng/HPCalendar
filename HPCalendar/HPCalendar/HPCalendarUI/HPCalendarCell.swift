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
	
	let dateLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
}
