//
//  SessionInProgressInteractor.swift
//  MeditationApp
//
//  Created by Mihindu de Silva on 17/1/20.
//  Copyright (c) 2020 Mihindu de Silva. All rights reserved.
//

import UIKit

protocol SessionInProgressInteractorInterface {
  func getInitialDuration(request: SessionInProgress.GetInitialDuration.Request)
  func startSession(request: SessionInProgress.StartSession.Request)
  func updateDuration(request: SessionInProgress.UpdateDuration.Request)
  var session: Session! { get set }
}

class SessionInProgressInteractor: SessionInProgressInteractorInterface {
  var presenter: SessionInProgressPresenterInterface!
  var worker: SessionInProgressWorker?
  var session: Session!
  var sessionTimer: Timer!
  
  // MARK: - Business logic
  
  func getInitialDuration(request: SessionInProgress.GetInitialDuration.Request) {
    update(duration: session.initialDuration)
  }
  
  func updateDuration(request: SessionInProgress.UpdateDuration.Request) {
    guard !session.currentDuration.isZero else {
      sessionTimer.invalidate()
      endSession()
      return
    }
    
    session.currentDuration.tickDown(bySeconds: request.timeInterval)
    update(duration: session.currentDuration)
  }
  
  func startSession(request: SessionInProgress.StartSession.Request) {
    sessionTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
      guard let self = self else { return }
      let request = SessionInProgress.UpdateDuration.Request(timeInterval: 1)
      self.updateDuration(request: request)
    }
  }
  
  private func update(duration: Duration) {
    let response = SessionInProgress.UpdateDuration.Response(duration: session.initialDuration)
    presenter.presentDuration(response: response)
  }
  
  private func endSession() {
    // TODO: Implement this
  }
}
