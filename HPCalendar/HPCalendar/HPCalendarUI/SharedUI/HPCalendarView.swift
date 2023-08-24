//
//  HPCalendarView.swift
//  HPCalendar
//
//  Created by Hsueh Peng Tseng on 2023/8/17.
//

import UIKit

public class HPCalendarView: UIView, UICollectionViewDataSource, UICollectionViewDelegate {
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
	
	private let weekDayHStack = WeekDayHStackView()
	
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
		
	private var viewModel: HPCalendarViewModel {
		didSet {
			collectionView.reloadData()
		}
	}
	
	// MARK: - LifeCycle
	
	init(frame: CGRect, viewModel: HPCalendarViewModel) {
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
		collectionView.register(HPCalendarCell.self, forCellWithReuseIdentifier: HPCalendarCell.reuseId)
	}
	
	private func bindViewModel() {
		viewModel.onReload = { [weak self] in
			self?.headerView.dateLabel.text = self?.viewModel.headerText
			self?.collectionView.reloadData()
		}
	}
	
	private func cellSize(in bounds: CGRect) -> CGSize {
		return CGSize(
			width: (collectionView.bounds.width - 32) / 7.0,
			height: (collectionView.bounds.height) / 6.0
		)
	}
	
	// MARK: - UICollectionViewDataSource
	
	public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return viewModel.days.count
	}
	
	public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HPCalendarCell.reuseId, for: indexPath) as? HPCalendarCell else { return UICollectionViewCell() }
		let day = viewModel.days[indexPath.item]
		let vm = HPCalendarCellViewModel(day: day)
		cell.viewModel = vm
		return cell
	}
	
	public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		viewModel.selectedDate(at: indexPath.item)
	}
	
	// MARK: - UI
	
	private func setupUI() {
		self.addSubview(headerView)
		self.addSubview(weekDayHStack)
		self.addSubview(collectionView)
		
		NSLayoutConstraint.activate([
			headerView.topAnchor.constraint(equalTo: self.topAnchor),
			headerView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
			headerView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
			headerView.heightAnchor.constraint(equalToConstant: 40)
		])
		
		NSLayoutConstraint.activate([
			weekDayHStack.topAnchor.constraint(equalTo: headerView.bottomAnchor),
			weekDayHStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
			weekDayHStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
			weekDayHStack.heightAnchor.constraint(equalToConstant: 34)
		])
		
		NSLayoutConstraint.activate([
			collectionView.topAnchor.constraint(equalTo: weekDayHStack.bottomAnchor),
			collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
			collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
			collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
		])
	}
}
