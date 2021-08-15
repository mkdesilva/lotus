//
//  CreateSessionView.swift
//  Lotus
//
//  Created by Mihindu de Silva on 18/12/19.
//  Copyright © 2019 Mihindu de Silva. All rights reserved.
//

import UIKit

protocol CreateSessionViewInterface: UIView {
  func setup()
  func tappedBegin()
}

final class CreateSessionView: UIView, CreateSessionViewInterface {
  
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
    picker.dataSource = delegate
    picker.delegate = delegate
    delegate.pickerView = picker
    
    let beginButton = BeginButton()
    beginButton.createSessionView = self
    
    let verticalStack = createStackView(arrangedSubviews: [picker, beginButton])
    addSubview(verticalStack)
    verticalStack.addConstraints(leadingSpacing: 16, trailingSpacing: -16)
    verticalStack.centerInSuperView()
    
    beginButton.setup(size: 100)
  }
  
  private func createStackView(arrangedSubviews: [UIView]) -> UIStackView {
    let stackView = UIStackView(arrangedSubviews: arrangedSubviews)
    stackView.axis = .vertical
    stackView.alignment = .center
    stackView.distribution = .fill
    stackView.spacing = 65
    return stackView
  }
  
  // MARK: - Event Handling
  
  func tappedBegin() {
    delegate.beginSession()
  }
}
