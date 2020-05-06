//
//  CreateSessionView.swift
//  MeditationApp
//
//  Created by Mihindu de Silva on 18/12/19.
//  Copyright © 2019 Mihindu de Silva. All rights reserved.
//

import UIKit

final class CreateSessionView: UIView, CustomView {
  
  weak var delegate: CreateSessionViewControllerDelegate!
  
  let startingMinutes = 5
  
  var flavourLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textAlignment = .center
    label.text = "Starting your journey"
    return label
  }()
  
  var durationButton: UIButton = {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.heightAnchor.constraint(equalToConstant: 50).isActive = true
    button.layer.cornerRadius = 15
    button.backgroundColor = Colors.slateBlue.color
    return button
  }()
  
  // MARK: - View Setup
  
  func setup() {
    addConstraintsEqualToSafeAreaSuperView()
    let verticalStack = UIStackView()
    verticalStack.axis = .vertical
    verticalStack.alignment = .center
    verticalStack.distribution = .fill
    
    addSubview(verticalStack)
    verticalStack.addConstraints(leadingSpacing: 16, trailingSpacing: -16)
    verticalStack.centerInSuperView()
    verticalStack.spacing = 65
    
    let upperStackView = createUpperStackView(arrangedSubviews: [flavourLabel, durationButton])
    verticalStack.addArrangedSubview(upperStackView)
    
    let beginButton = BeginButton()
    beginButton.createSessionView = self
    verticalStack.addArrangedSubview(beginButton)
    beginButton.setup(size: UIScreen.main.bounds.height / 3)
    setupDurationButton(verticalStack)
  }
  
  private func createUpperStackView(arrangedSubviews: [UIView]) -> UIStackView {
    let stackView = UIStackView(arrangedSubviews: arrangedSubviews)
    stackView.axis = .vertical
    stackView.alignment = .center
    stackView.spacing = 35
    return stackView
  }
  
  private func setupDurationButton(_ verticalStack: UIStackView) {
    durationButton.setTitle("\(startingMinutes) minutes", for: .normal)
    durationButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
    durationButton.leadingAnchor.constraint(equalTo: verticalStack.leadingAnchor).isActive = true
    durationButton.trailingAnchor.constraint(equalTo: verticalStack.trailingAnchor).isActive = true
    
    durationButton.addTarget(self, action: #selector(tappedDuration), for: .touchUpInside)
  }
}

extension CreateSessionView {
  
  // MARK: - Event Handling
  
  @objc func tappedDuration() {
    delegate.showDurationPicker()
  }
  
  func tappedBegin() {
    delegate.beginSession()
  }
  
  func displayDuration(durationTitle: String) {
    durationButton.setTitle(durationTitle, for: .normal)
  }
}
