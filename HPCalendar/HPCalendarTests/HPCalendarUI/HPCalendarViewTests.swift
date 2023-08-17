//
//  UICalendarViewTests.swift
//  HPCalendarTests
//
//  Created by Hsueh Peng Tseng on 2023/8/17.
//

import XCTest
import UIKit

class HPCalendarView: UIView, UICollectionViewDataSource {
	// MARK: - Properties
	
	private let flowLayout: UICollectionViewFlowLayout = {
		let layout = UICollectionViewFlowLayout()
		return layout
	}()
	
	private lazy var collectionView: UICollectionView = {
		let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
		collectionView.translatesAutoresizingMaskIntoConstraints = false
		return collectionView
	}()
	
	// MARK: - LifeCycle
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		collectionView.dataSource = self
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: - UICollectionViewDataSource
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return 35
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		return UICollectionViewCell()
	}
}

final class HPCalendarViewTests: XCTestCase {

	func test_init_renderCorrectNumbersOfCalendarCell() {
		let sut = HPCalendarView()
		
		XCTAssertEqual(sut.numbersOfCalendarCell(), numbersOfCalendarCell)
	}
	
	// MARK: - Helpers
	
	var numbersOfCalendarCell = 35
}

extension HPCalendarView {
	func numbersOfCalendarCell() -> Int {
		return collectionView.numberOfItems(inSection: calendarSection)
	}
	
	private var calendarSection: Int {
		return 0
	}
}


