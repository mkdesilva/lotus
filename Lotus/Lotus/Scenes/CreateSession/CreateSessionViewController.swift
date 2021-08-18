//
//  CreateSessionViewController.swift
//  Lotus
//
//  Created by Mihindu de Silva on 8/11/19.
//  Copyright (c) 2019 Mihindu de Silva. All rights reserved.
//

import UIKit

protocol CreateSessionViewControllerDelegate: class, UIPickerViewDelegate, UIPickerViewDataSource {
  func beginSession()
  var pickerView: UIPickerView! { get set }
}

protocol CreateSessionViewControllerInterface: class {
  func displayInitialDuration(viewModel: CreateSession.SetDuration.ViewModel)
}

class CreateSessionViewController: UIViewController, CreateSessionViewControllerInterface {
  
  var interactor: CreateSessionInteractorInterface!
  var router: CreateSessionRouterInterface!
  var createSessionView: CreateSessionView!
  var pickerView: UIPickerView!
  
  var initialDuration: SessionDuration?
  
  let hours = Array(0...12)
  let minutes = Array(0...59)
  let seconds = Array(0...59)
  
  enum DurationComponent: Int, CaseIterable {
    case hours = 0
    case minutes = 1
    case seconds = 2
  }
  
  // MARK: - Configuration
  
  private func configure(viewController: CreateSessionViewController) {
    let router = CreateSessionRouter()
    router.viewController = viewController
    
    let presenter = CreateSessionPresenter()
    presenter.viewController = viewController
    
    let interactor = CreateSessionInteractor()
    interactor.presenter = presenter
    interactor.worker = CreateSessionWorker(store: CreateSessionStore())
    
    viewController.interactor = interactor
    viewController.router = router
  }
  
  // MARK: - View lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configure(viewController: self)
    createView()
    
    getInitialDuration()
  }
  
  private func createView() {
    let blurredBackgroundView = BlurredBackgroundView(image: Assets.lake.image)
    view.addSubview(blurredBackgroundView)
    createSessionView = CreateSessionView()
    view.addSubview(createSessionView)
    createSessionView.delegate = self
    createSessionView.setup()
  }
  
  func getInitialDuration() {
    let request = CreateSession.GetInitialDuration.Request()
    interactor.getInitialDuration(request: request)
  }
  
  // MARK: - Display logic
  
  func displayInitialDuration(viewModel: CreateSession.SetDuration.ViewModel) {
  }
}

extension CreateSessionViewController: CreateSessionViewControllerDelegate {
  
  // MARK: - Event handling
  
  func beginSession() {
    // Get duration
    let hours = pickerView.selectedRow(inComponent: DurationComponent.hours.rawValue)
    let minutes = pickerView.selectedRow(inComponent: DurationComponent.minutes.rawValue)
    let seconds = pickerView.selectedRow(inComponent: DurationComponent.seconds.rawValue)
    
    let duration = SessionDuration(hours: hours, minutes: minutes, seconds: seconds)
    
    // Don't allow a session to start if the duration is zero
    guard !duration.isZero else { return }
    
    routeToBeginSession(duration: duration)
  }
  
  // MARK: - Router
  
  func routeToBeginSession(duration: SessionDuration) {
    router.navigateToInProgressScene(duration: duration)
  }
}

extension CreateSessionViewController: UIPickerViewDelegate, UIPickerViewDataSource {
  
  private func setupPickerView(for duration: SessionDuration) {
    if let initialHours = hours.firstIndex(of: duration.hours) {
      pickerView.selectRow(initialHours, inComponent: DurationComponent.hours.rawValue, animated: false)
    }
    
    if let initialMinutes = minutes.firstIndex(of: duration.minutes) {
      pickerView.selectRow(initialMinutes, inComponent: DurationComponent.minutes.rawValue, animated: false)
    }
    
    if let initialSeconds = seconds.firstIndex(of: duration.seconds) {
      pickerView.selectRow(initialSeconds, inComponent: DurationComponent.seconds.rawValue, animated: false)
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
    case .seconds:
      return seconds.count
    }
  }
  
  func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
    var label: UILabel!
    
    if let labelView = view as? UILabel {
      label = labelView
    } else {
      label = UILabel()
    }
    
    label.textAlignment = .center
    label.text = getText(forRow: row, forComponent: component)
    return label
  }
  
  private func getText(forRow row: Int, forComponent component: Int) -> String {
    guard let durationComponent = DurationComponent(rawValue: component) else { return "?" }
    
    var unitArray: [Int] = []
    var text: String = ""
    
    switch durationComponent {
    case .hours:
      unitArray = hours
      text = hours[row] == 1 ? "hour":  "hours"
    case .minutes:
      unitArray = minutes
      text = "min"
    case .seconds:
      unitArray = seconds
      text = "sec"
    }
    
    return "\(unitArray[row]) \(text)"
  }
  
  func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
    if component == DurationComponent.hours.rawValue {
      return 80
    }
    return 60
  }
  
  func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
    return 40
  }
}
