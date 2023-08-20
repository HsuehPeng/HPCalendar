//
//  HPCalendarView.swift
//  HPCalendar
//
//  Created by Hsueh Peng Tseng on 2023/8/17.
//

import UIKit

class HPSingleSelectionCalendarView: UIView, UICollectionViewDataSource {
	// MARK: - Properties
	
	lazy var headerView: HPCalendarHeaderView = {
		let view = HPCalendarHeaderView(frame: .zero) { [weak self] in
			self?.viewModel.setNextBaseDate()
		} onPreviousButtonTapped: { [weak self] in
			self?.viewModel.setPreviousBaseDate()
		}

		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()
	
	private let flowLayout: UICollectionViewFlowLayout = {
		let layout = UICollectionViewFlowLayout()
		return layout
	}()
	
	lazy var collectionView: UICollectionView = {
		let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
		collectionView.translatesAutoresizingMaskIntoConstraints = false
		return collectionView
	}()
		
	private var viewModel: HPSingleCalendarViewModel {
		didSet {
			collectionView.reloadData()
		}
	}
	
	// MARK: - LifeCycle
	
	init(frame: CGRect, viewModel: HPSingleCalendarViewModel) {
		self.viewModel = viewModel
		super.init(frame: frame)
		
		headerView.dateLabel.text = viewModel.headerText
		configureCollectionView()
		bindViewModel()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: - Helpers
	
	private func configureCollectionView() {
		collectionView.dataSource = self
		collectionView.register(HPSingleSelectionCalendarCell.self, forCellWithReuseIdentifier: HPSingleSelectionCalendarCell.reuseId)
	}
	
	private func bindViewModel() {
		viewModel.onSetBaseDate = { [weak self] in
			self?.headerView.dateLabel.text = self?.viewModel.headerText
			self?.collectionView.reloadData()
		}
	}
	
	// MARK: - UICollectionViewDataSource
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return viewModel.days.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HPSingleSelectionCalendarCell.reuseId, for: indexPath) as? HPSingleSelectionCalendarCell else { return UICollectionViewCell() }
		let day = viewModel.days[indexPath.item]
		cell.dateLabel.text = day.number
		cell.dateLabel.textColor = day.isWithInMonth ? HPSingleSelectionCalendarUIConfiguration.withinMonthTextColor : HPSingleSelectionCalendarUIConfiguration.notWithinMonthTextColor
		cell.dateLabel.textColor = day.isToday ? HPSingleSelectionCalendarUIConfiguration.todayTextColor : cell.dateLabel.textColor
		return cell
	}
}
