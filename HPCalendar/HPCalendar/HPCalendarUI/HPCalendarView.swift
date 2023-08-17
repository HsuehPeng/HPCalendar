//
//  HPCalendarView.swift
//  HPCalendar
//
//  Created by Hsueh Peng Tseng on 2023/8/17.
//

import UIKit

class HPCalendarView: UIView, UICollectionViewDataSource {
	// MARK: - Properties
	
	private let flowLayout: UICollectionViewFlowLayout = {
		let layout = UICollectionViewFlowLayout()
		return layout
	}()
	
	lazy var collectionView: UICollectionView = {
		let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
		collectionView.translatesAutoresizingMaskIntoConstraints = false
		return collectionView
	}()
	
	private var viewModel: HPCalendarViewModel? {
		didSet {
			collectionView.reloadData()
		}
	}
	
	// MARK: - LifeCycle
	
	convenience init(frame: CGRect, viewModel: HPCalendarViewModel) {
		self.init(frame: frame)
		self.viewModel = viewModel
		collectionView.dataSource = self
		collectionView.register(HPCalendarCell.self, forCellWithReuseIdentifier: HPCalendarCell.reuseId)
	}
	
	// MARK: - UICollectionViewDataSource
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return 35
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HPCalendarCell.reuseId, for: indexPath) as? HPCalendarCell else { return UICollectionViewCell() }
		cell.dateLabel.text = viewModel?.days[indexPath.item].number
		return cell
	}
}
