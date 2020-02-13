//
//  SessionInProgressViewController.swift
//  MeditationApp
//
//  Created by Mihindu de Silva on 17/1/20.
//  Copyright (c) 2020 Mihindu de Silva. All rights reserved.
//

import UIKit

protocol SessionInProgressViewControllerInterface: class {
  func displayDuration(viewModel: SessionInProgress.UpdateDuration.ViewModel)
}

protocol SessionInProgressViewControllerDelegate: class {
  func tappedEndButton()
}

class SessionInProgressViewController: UIViewController, SessionInProgressViewControllerInterface {
  var interactor: SessionInProgressInteractorInterface!
  var router: SessionInProgressRouter!
  
  var sessionInProgressView: SessionInProgressView!
  
  // MARK: - Object lifecycle
  
  override func awakeFromNib() {
    super.awakeFromNib()
    configure(viewController: self)
  }
  
  // MARK: - Configuration
  
  private func configure(viewController: SessionInProgressViewController) {
    let router = SessionInProgressRouter()
    router.viewController = viewController
    
    let presenter = SessionInProgressPresenter()
    presenter.viewController = viewController
    
    let interactor = SessionInProgressInteractor()
    interactor.presenter = presenter
    interactor.worker = SessionInProgressWorker(store: SessionInProgressStore())
    
    viewController.interactor = interactor
    viewController.router = router
  }
  
  // MARK: - View lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    createView()
  }
  
  private func createView() {
    configure(viewController: self)
    sessionInProgressView = SessionInProgressView()
    view.addSubview(sessionInProgressView)
    sessionInProgressView.setup(delegate: self)
    getInitialDuration()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    startSession()
  }
  
  // MARK: - Event handling
  
  func getInitialDuration() {
    // TODO: Delete this
    interactor.session = Session(initialDuration: Duration(hours: 0, minutes: 2, seconds: 3))
    
    let request = SessionInProgress.GetInitialDuration.Request()
    interactor.getInitialDuration(request: request)
  }
  
  func startSession() {
    let request = SessionInProgress.StartSession.Request()
    interactor.startSession(request: request)
    sessionInProgressView.startAnimatingProgressCircle(durationInSeconds: interactor.session.initialDuration.totalSeconds)
  }
  
  // MARK: - Display logic
  
  func displayDuration(viewModel: SessionInProgress.UpdateDuration.ViewModel) {
    sessionInProgressView.setTimeText(viewModel.durationText)
  }
  
  // MARK: - Router
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    router.passDataToNextScene(segue: segue)
  }
  
  @IBAction func unwindToSessionInProgressViewController(from segue: UIStoryboardSegue) {
    print("unwind...")
    router.passDataToNextScene(segue: segue)
  }
}

extension SessionInProgressViewController: SessionInProgressViewControllerDelegate {
  func tappedEndButton() {
    print("Tapped end button")
  }
  
}
