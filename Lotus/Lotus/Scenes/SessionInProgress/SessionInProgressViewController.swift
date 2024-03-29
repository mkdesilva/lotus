//
//  SessionInProgressViewController.swift
//  Lotus
//
//  Created by Mihindu de Silva on 17/1/20.
//  Copyright (c) 2020 Mihindu de Silva. All rights reserved.
//

import UIKit

protocol SessionInProgressViewControllerInterface: AnyObject {
  func displayDuration(viewModel: SessionInProgress.UpdateDuration.ViewModel)
  func displayPaused(viewModel: SessionInProgress.TogglePause.ViewModel)
  func displayEndSession(viewModel: SessionInProgress.EndSession.ViewModel)
}

protocol SessionInProgressViewDelegate: AnyObject {
  func tappedEndButton()
  func tappedPauseButton()
}

class SessionInProgressViewController: UIViewController, SessionInProgressViewControllerInterface {
  var endSessionInProgress = false
  var interactor: SessionInProgressInteractorInterface!
  var router: SessionInProgressRouterInterface!
  
  var sessionInProgressView: SessionInProgressView!
  var audioController: AudioControllerInterface!

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
    
    viewController.interactor = interactor
    viewController.router = router
    
    audioController = AudioController()
  }
  
  // MARK: - View lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    if interactor == nil {
      configure(viewController: self)
    }
    
    createView()
  }
  
  private func createView() {
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
    let request = SessionInProgress.GetInitialDuration.Request()
    interactor.getInitialDuration(request: request)
  }
  
  func startSession() {
    let request = SessionInProgress.StartSession.Request()
    interactor.startSession(request: request)
    ringBowl()
    
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
  
  func ringBowl() {
    audioController.playAudio(fileName: "bowl-hit", fileExtension: "wav")
  }
  
  func ringBowl(numberOfTimes: Int) {
    // Going to skip duration for now as it's quite long but the volume tapers off
//    let duration = audioController.getFileDuration(fileName: "bowl-hit")
    for _ in 1...numberOfTimes {
      audioController.playAudio(fileName: "bowl-hit", fileExtension: "wav")
      sleep(2)
    }
  }
  
  func displayEndSession(viewModel: SessionInProgress.EndSession.ViewModel) {
    endSessionInProgress = true
    if viewModel.playEndSound {
      ringBowl(numberOfTimes: 3)
    }
    
    audioController.disableAudioSession()
    sessionInProgressView.endSession {
      self.router.navigateToEndSession(sessionStats: viewModel.sessionStats)
    }
  }
  
}

extension SessionInProgressViewController: SessionInProgressViewDelegate {
  func tappedPauseButton() {
    let request = SessionInProgress.TogglePause.Request()
    interactor.togglePause(request: request)
  }
  
  func tappedEndButton() {
    guard !endSessionInProgress else { return }
    let request = SessionInProgress.EndSession.Request(playEndSound: false)
    interactor.endSession(request: request)
  }
}
