//
//  HPCalendarHeaderView.swift
//  HPCalendar
//
//  Created by Hsueh Peng Tseng on 2023/8/17.
//

import UIKit

class HPCalendarHeaderView: UIView {
	let dateLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.textAlignment = .center
		return label
	}()
	
	lazy var nextButton: UIButton = {
		let button = UIButton()
		button.translatesAutoresizingMaskIntoConstraints = false
		button.addTarget(self, action: #selector(didTapNextButton), for: .touchUpInside)
		button.setImage(UIImage(named: "Icon_32px_Forward"), for: .normal)
		button.backgroundColor = .red
		return button
	}()
	
	lazy var previousButton: UIButton = {
		let button = UIButton()
		button.translatesAutoresizingMaskIntoConstraints = false
		button.addTarget(self, action: #selector(didTapPreviousButton), for: .touchUpInside)
		button.setImage(UIImage(named: "Icon_32px_Back"), for: .normal)
		button.backgroundColor = .red
		return button
	}()
	
	private let hStack: UIStackView = {
		let stackView = UIStackView()
		stackView.axis = .horizontal
		stackView.alignment = .center
		stackView.distribution = .fillProportionally
		stackView.translatesAutoresizingMaskIntoConstraints = false
		return stackView
	}()
	
	var onNextButtonTapped: (() -> Void)
	var onPreviousButtonTapped: (() -> Void)
	
	@objc func didTapNextButton() {
		onNextButtonTapped()
	}
	
	@objc func didTapPreviousButton() {
		onPreviousButtonTapped()
	}
	
	init(frame: CGRect, onNextButtonTapped: @escaping () -> Void, onPreviousButtonTapped: @escaping () -> Void) {
		self.onNextButtonTapped = onNextButtonTapped
		self.onPreviousButtonTapped = onPreviousButtonTapped
		super.init(frame: frame)
		
		setupUI()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func setupUI() {
		self.addSubview(hStack)
		hStack.addArrangedSubviews(subviews: [previousButton, dateLabel, nextButton])
		
		NSLayoutConstraint.activate([
			previousButton.widthAnchor.constraint(equalToConstant: 32),
			previousButton.heightAnchor.constraint(equalToConstant: 32)
		])
		
		NSLayoutConstraint.activate([
			nextButton.widthAnchor.constraint(equalToConstant: 32),
			nextButton.heightAnchor.constraint(equalToConstant: 32)
		])
		
		NSLayoutConstraint.activate([
			hStack.topAnchor.constraint(equalTo: self.topAnchor),
			hStack.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
			hStack.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16),
			hStack.bottomAnchor.constraint(equalTo: self.bottomAnchor)
		])
	}
	
}
