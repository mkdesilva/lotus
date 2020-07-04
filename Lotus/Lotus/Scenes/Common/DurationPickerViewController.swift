//
//  DurationPickerViewController.swift
//  Lotus
//
//  Created by Mihindu de Silva on 20/12/19.
//  Copyright © 2019 Mihindu de Silva. All rights reserved.
//

import UIKit

protocol DurationPickerDelegate: UIPickerViewDelegate, UIPickerViewDataSource {
  func saveAndClose()
  func cancelAndClose()
  var pickerView: UIPickerView! { get set }
}

class DurationPickerViewController: UIViewController {
  
  var pickerView: UIPickerView!
  var initialDuration: SessionDuration?
  
  let minutesInterval = 15 // TODO: Make this user customizable
  let hours = Array(0...8)
  
  weak var delegate: CreateSessionViewControllerDelegate!
  
  lazy var minutes: [Int] = {
    return Array(0...59).filter { $0.isMultiple(of: minutesInterval) }
  }()
  
  init(modalPresentationStyle: UIModalPresentationStyle = .overFullScreen) {
    super.init(nibName: nil, bundle: nil)
    self.modalPresentationStyle = modalPresentationStyle
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let durationView = DurationPickerHalfView(viewController: self, frame: view.frame)
    view.addSubview(durationView)
    
    if let duration = initialDuration {
      setupPickerView(for: duration)
    }
  }
}

extension DurationPickerViewController: DurationPickerDelegate {
  
  enum DurationComponent: Int, CaseIterable {
    case hours = 0
    case minutes = 1
  }
  
  private func setupPickerView(for duration: SessionDuration) {
    if let initialHours = hours.firstIndex(of: duration.hours) {
      pickerView.selectRow(initialHours, inComponent: DurationComponent.hours.rawValue, animated: false)
    }
    
    if let initialMinutes = minutes.firstIndex(of: duration.minutes) {
      pickerView.selectRow(initialMinutes, inComponent: DurationComponent.minutes.rawValue, animated: false)
    }
  }
  
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return DurationComponent.allCases.count
  }
  
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    guard let durationComponent = DurationComponent(rawValue: component) else { return 0 }
    
    switch durationComponent {
    case .hours:
      return hours.count
    case .minutes:
      return minutes.count
    }
  }
  
  func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
    var label: UILabel!
    
    if let labelView = view as? UILabel {
      label = labelView
    } else {
      label = UILabel()
    }
    
    label.textColor = .black
    label.textAlignment = .center
    label.text = getText(forRow: row, forComponent: component)
    
    return label
  }
  
  private func getText(forRow row: Int, forComponent component: Int) -> String {
    guard let durationComponent = DurationComponent(rawValue: component) else { return "?" }
    
    switch durationComponent {
    case .hours:
      return "\(hours[row])h"
    case .minutes:
      return "\(minutes[row])m"
    }
  }
  
  func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
    return 60
  }
  
  func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
    return 40
  }
  
  func saveAndClose() {
    let duration = SessionDuration(
      hours: hours[pickerView.selectedRow(inComponent: DurationComponent.hours.rawValue)],
      minutes: minutes[pickerView.selectedRow(inComponent: DurationComponent.minutes.rawValue)]
    )
    
    delegate.didSelectDuration(duration: duration)
    self.dismiss(animated: true)
  }
  
  func cancelAndClose() {
    self.dismiss(animated: true)
  }
  
}
