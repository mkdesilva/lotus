//
//  SessionInProgressInteractor.swift
//  Lotus
//
//  Created by Mihindu de Silva on 17/1/20.
//  Copyright (c) 2020 Mihindu de Silva. All rights reserved.
//

import UIKit

protocol SessionInProgressInteractorInterface {
  func getInitialDuration(request: SessionInProgress.GetInitialDuration.Request)
  func startSession(request: SessionInProgress.StartSession.Request)
  func updateDuration(request: SessionInProgress.UpdateDuration.Request)
  func togglePause(request: SessionInProgress.TogglePause.Request)
  func endSession(request: SessionInProgress.EndSession.Request)
  var session: Session! { get set }
}

class SessionInProgressInteractor: SessionInProgressInteractorInterface {
  var presenter: SessionInProgressPresenterInterface!
  var session: Session!
  var sessionTimer: Timer!
  
  // MARK: - Business logic
  
  func getInitialDuration(request: SessionInProgress.GetInitialDuration.Request) {
    update(duration: session.initialDuration)
  }
  
  func updateDuration(request: SessionInProgress.UpdateDuration.Request) {
    guard !session.remainingDuration.isZero else {
      sessionTimer.invalidate()
      endSession(request: SessionInProgress.EndSession.Request(playEndSound: true))
      return
    }
    
    session.remainingDuration.tickDown(by: request.timeInterval)
    update(duration: session.remainingDuration)
  }
  
  func startSession(request: SessionInProgress.StartSession.Request) {
    startTimer()
  }
  
  private func update(duration: SessionDuration) {
    let response = SessionInProgress.UpdateDuration.Response(duration: session.remainingDuration)
    presenter.presentDuration(response: response)
  }
  
  private var timerStartTime: Double = 0
  
  private func startTimer() {
    session.isInProgress = true
    self.timerStartTime = Date().timeIntervalSinceReferenceDate

    sessionTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
      guard let self = self else { return }
      let request = SessionInProgress.UpdateDuration.Request(timeInterval: 1)
      self.updateDuration(request: request)
      self.timerStartTime = Date().timeIntervalSinceReferenceDate
    }
  }

  func togglePause(request: SessionInProgress.TogglePause.Request) {
    if session.isInProgress {
      // Session is in progress, pause the session
      session.isInProgress = false
      sessionTimer.invalidate()
      // Calculate time interval since timer was started
      let pauseTime = Date().timeIntervalSinceReferenceDate - timerStartTime
      session.remainingDuration.tickDown(by: pauseTime)
      let response = SessionInProgress.TogglePause.Response(isPaused: true)
      presenter.presentPaused(response: response)
    } else {
      // session is already paused, resume the session
      resume()
    }
  }
  
  private func resume() {
    startTimer()
    presenter.presentPaused(response: SessionInProgress.TogglePause.Response(isPaused: false))
    let response = SessionInProgress.UpdateDuration.Response(duration: session.remainingDuration)
    presenter.presentDuration(response: response)
  }
  
  func endSession(request: SessionInProgress.EndSession.Request) {
    if (sessionTimer != nil), sessionTimer.isValid {
      sessionTimer.invalidate()
    }
    
    let elapsedDuration = session.initialDuration - session.remainingDuration
    
    let date = Date()
    let sessionStats = SessionStats(duration: elapsedDuration.time, date: date)
    
    let response = SessionInProgress.EndSession.Response(sessionStats: sessionStats, playEndSound: request.playEndSound)
    presenter.presentEndSession(response: response)
  }
}
