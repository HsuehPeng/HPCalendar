//
//  HPCalendarView.swift
//  HPCalendar
//
//  Created by Hsueh Peng Tseng on 2023/8/17.
//

import UIKit

public class HPSingleSelectionCalendarView: UIView, UICollectionViewDataSource, UICollectionViewDelegate {
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
	
	let weekDayHStack: UIStackView = {
		let stackView = UIStackView()
		stackView.axis = .horizontal
		stackView.spacing = 0
		stackView.distribution = .fillEqually
		stackView.alignment = .fill
		stackView.translatesAutoresizingMaskIntoConstraints = false
		return stackView
	}()
	
	lazy var weekDaysLabel: [UILabel] = {
		let weekDaysString = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
		var labels = [UILabel]()
		
		for day in weekDaysString {
			labels.append(makeWeekDayLabel(weekDay: day))
		}
		
		return labels
	}()
	
	private let flowLayout: UICollectionViewFlowLayout = {
		let layout = UICollectionViewFlowLayout()
		layout.minimumInteritemSpacing = 0
		layout.minimumLineSpacing = 0
		layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
		return layout
	}()
	
	lazy var collectionView: UICollectionView = {
		let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
		collectionView.isScrollEnabled = false
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
		
		setupUI()
		headerView.dateLabel.text = viewModel.headerText
		configureCollectionView()
		bindViewModel()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	public override func layoutSubviews() {
		super.layoutSubviews()
		
		flowLayout.itemSize = cellSize(in: self.bounds)
	}
	
	// MARK: - Helpers
	
	private func configureCollectionView() {
		collectionView.dataSource = self
		collectionView.delegate = self
		collectionView.register(HPSingleSelectionCalendarCell.self, forCellWithReuseIdentifier: HPSingleSelectionCalendarCell.reuseId)
	}
	
	private func bindViewModel() {
		viewModel.onSetBaseDate = { [weak self] in
			self?.headerView.dateLabel.text = self?.viewModel.headerText
			self?.collectionView.reloadData()
		}
	}
	
	private func cellSize(in bounds: CGRect) -> CGSize {
		return CGSize(
			width:   (collectionView.bounds.width - 32) / 7.0,
			height: (collectionView.bounds.height) / 6.0
		)
	}
	
	// MARK: - UICollectionViewDataSource
	
	public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return viewModel.days.count
	}
	
	public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HPSingleSelectionCalendarCell.reuseId, for: indexPath) as? HPSingleSelectionCalendarCell else { return UICollectionViewCell() }
		let day = viewModel.days[indexPath.item]
		cell.dateLabel.text = day.number
		cell.dateLabel.textColor = day.isWithInMonth ? HPSingleSelectionCalendarUIConfiguration.withinMonthTextColor : HPSingleSelectionCalendarUIConfiguration.notWithinMonthTextColor
		cell.dateLabel.textColor = day.isToday ? HPSingleSelectionCalendarUIConfiguration.todayTextColor : cell.dateLabel.textColor
		return cell
	}
	
	public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HPSingleSelectionCalendarCell.reuseId, for: indexPath) as? HPSingleSelectionCalendarCell else { return }
		guard viewModel.days[indexPath.item].isWithInMonth else { return }
		
		cell.selectionView.backgroundColor = HPSingleSelectionCalendarUIConfiguration.calendarCellSelectionColor
		cell.dateLabel.textColor = .white
	}
}
