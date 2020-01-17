//
//  DurationPickerHalfView.swift
//  MeditationApp
//
//  Created by Mihindu de Silva on 20/12/19.
//  Copyright © 2019 Mihindu de Silva. All rights reserved.
//

import UIKit

class DurationPickerHalfView: UIView, CustomView {
  
  weak var pickerDelegate: DurationPickerDelegate!
  
  // MARK: - View Initialisation
  
  init(viewController: DurationPickerDelegate, frame: CGRect) {
    self.pickerDelegate = viewController
    super.init(frame: frame)
    setup()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - View Components
  
  var pickerLabel: UILabel = {
    let label = UILabel()
    label.text = "Choose your duration"
    label.textColor = .black
    label.textAlignment = .center
    label.font = UIFont.boldSystemFont(ofSize: 18)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  var cancelButton: UIButton = {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.widthAnchor.constraint(equalToConstant: 50).isActive = true
    button.setImage(Assets.xmark.image, for: .normal)
    button.addTarget(self, action: #selector(tapCancel), for: .touchUpInside)
    return button
  }()
  
  var doneButton: UIButton = {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.widthAnchor.constraint(equalToConstant: 80).isActive = true
    //    button.heightAnchor.constraint(equalToConstant: 30).isActive = true
    
    let font = UIFont.boldSystemFont(ofSize: 18)
    let textColor = Colors.slateBlue.color
    
    let title = NSAttributedString(
      string: "Done",
      attributes: [
        NSAttributedString.Key.font: font,
        NSAttributedString.Key.foregroundColor: textColor
      ]
    )
    button.setAttributedTitle(title, for: .normal)
    
    button.addTarget(self, action: #selector(tapClose), for: .touchUpInside)
    
    return button
  }()
  
  var pickerView: UIPickerView!
  
  // MARK: - Creating the view
  
  func setup() {
    addUpperDeadArea()
    
    let bottomControlView = createBottomControlView()
    addSubview(bottomControlView)
    
    let dismissPortionView = UIView()
    bottomControlView.addSubview(dismissPortionView)
    
    let stackView = UIStackView(arrangedSubviews: [cancelButton, pickerLabel, doneButton])
    stackView.axis = .horizontal
    dismissPortionView.addSubview(stackView)
    
    let pickerView = UIPickerView()
    pickerView.dataSource = pickerDelegate
    pickerView.delegate = pickerDelegate
    pickerDelegate.pickerView = pickerView
    bottomControlView.addSubview(pickerView)
    
    // Setting up constraints
    dismissPortionView.addConstraints(topSpacing: 0, leadingSpacing: 0, trailingSpacing: -16)
    stackView.addConstraints(topSpacing: 16, leadingSpacing: 16, trailingSpacing: -16, bottomSpacing: -16)
    stackView.constraintHeight(equalToConstant: 50)
    setupConstraints(pickerView, dismissPortionView)
    pickerView.bottomAnchor.constraint(equalTo: bottomControlView.bottomAnchor).isActive = true
    
  }
  
  private func addUpperDeadArea() {
    let deadArea = UIView()
    deadArea.backgroundColor = .clear
    
    let blur = UIBlurEffect(style: .light)
    let blurView = UIVisualEffectView(effect: blur)
    deadArea.insertSubview(blurView, at: 0)
    blurView.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height / 1.75)
    
    addSubview(deadArea)
    
    let button = UIButton(frame: blurView.frame)
    button.backgroundColor = .clear
    button.addTarget(self, action: #selector(tapClose), for: .touchUpInside)
    addSubview(button)
  }
  
  private func createBottomControlView() -> UIView {
    let view = UIView()
    view.backgroundColor = .white
    view.frame = CGRect(x: 0, y: frame.height / 2, width: frame.width, height: frame.height / 2)
    view.layer.cornerRadius = 20
    return view
  }
  
  private func setupConstraints(_ pickerView: UIPickerView, _ constraintToView: UIView) {
    pickerView.translatesAutoresizingMaskIntoConstraints = false
    pickerView.topAnchor.constraint(equalTo: constraintToView.bottomAnchor).isActive = true
    pickerView.leadingAnchor.constraint(equalTo: constraintToView.leadingAnchor).isActive = true
    pickerView.trailingAnchor.constraint(equalTo: constraintToView.trailingAnchor).isActive = true
  }
  
  // MARK: - Handling user events
    
  @objc func tapClose() {
    //    let duration =
    pickerDelegate.saveAndClose()
  }
  
  @objc func tapCancel() {
    pickerDelegate.cancelAndClose()
  }
}
