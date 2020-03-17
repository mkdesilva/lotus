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
  func displayPaused(viewModel: SessionInProgress.TogglePause.ViewModel)
  func displayEndSession(viewModel: SessionInProgress.EndSession.ViewModel)
}

protocol SessionInProgressViewDelegate: class {
  func tappedEndButton()
  func tappedPauseButton()
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
    print("view did load")
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
    interactor.session = Session(initialDuration: SessionDuration(hours: 0, minutes: 0, seconds: 1))
    
    let request = SessionInProgress.GetInitialDuration.Request()
    interactor.getInitialDuration(request: request)
  }
  
  func startSession() {
    let request = SessionInProgress.StartSession.Request()
    interactor.startSession(request: request)
    sessionInProgressView.startAnimatingProgressCircle(durationInSeconds: Int(interactor.session.initialDuration.time))
  }
  
  // MARK: - Display logic
  
  func displayDuration(viewModel: SessionInProgress.UpdateDuration.ViewModel) {
    sessionInProgressView.setTimeText(viewModel.durationText)
  }
  
  func displayPaused(viewModel: SessionInProgress.TogglePause.ViewModel) {
    if viewModel.isPaused {
      sessionInProgressView.showPausedView()
    } else {
      sessionInProgressView.showInProgressView()
    }
  }
  
  func displayEndSession(viewModel: SessionInProgress.EndSession.ViewModel) {
    sessionInProgressView.endSession {
      self.router.navigateToEndSession()
    }
  }
  
  func finishedEndAnimation() {
    
  }
}

extension SessionInProgressViewController: SessionInProgressViewDelegate {
  func tappedPauseButton() {
    let request = SessionInProgress.TogglePause.Request()
    interactor.togglePause(request: request)
  }
  
  func tappedEndButton() {
    print("Tapped end button")
  }
  
}
