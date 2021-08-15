//
//  CreateSessionView.swift
//  Lotus
//
//  Created by Mihindu de Silva on 18/12/19.
//  Copyright © 2019 Mihindu de Silva. All rights reserved.
//

import UIKit

final class CreateSessionView: UIView, CustomView {
  
  weak var delegate: CreateSessionViewControllerDelegate!
  
  let startingMinutes = 5
  
  let picker: UIPickerView = {
    let pickerView = UIPickerView()
    pickerView.translatesAutoresizingMaskIntoConstraints = false
    pickerView.addConstraints(topSpacing: 16, leadingSpacing: 16, trailingSpacing: 16)
    pickerView.constraintHeight(equalToConstant: 200)
    return pickerView
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
    
    picker.dataSource = delegate
    picker.delegate = delegate
    delegate.pickerView = picker
    
    let upperStackView = createUpperStackView(arrangedSubviews: [picker])
    verticalStack.addArrangedSubview(upperStackView)
    
    let beginButton = BeginButton()
    beginButton.createSessionView = self
    verticalStack.addArrangedSubview(beginButton)
    beginButton.setup(size: 100)
  }
  
  private func createUpperStackView(arrangedSubviews: [UIView]) -> UIStackView {
    let stackView = UIStackView(arrangedSubviews: arrangedSubviews)
    stackView.axis = .vertical
    stackView.alignment = .center
    stackView.spacing = 35
    return stackView
  }
}

extension CreateSessionView {
  
  // MARK: - Event Handling
  
  func tappedBegin() {
    delegate.beginSession()
  }
}
