//
//  CreateSessionInteractor.swift
//  MeditationApp
//
//  Created by Mihindu de Silva on 8/11/19.
//  Copyright (c) 2019 Mihindu de Silva. All rights reserved.
//

import UIKit

protocol CreateSessionInteractorInterface {
  func setDuration(request: CreateSession.SetDuration.Request)
  func getInitialDuration(request: CreateSession.GetInitialDuration.Request)
  var sessionDuration: Duration? { get set }
}

class CreateSessionInteractor: CreateSessionInteractorInterface {
  
  var presenter: CreateSessionPresenterInterface!
  var worker: CreateSessionWorker?
  
  var sessionDuration: Duration?
  
  // MARK: - Business logic
  
  func getInitialDuration(request: CreateSession.GetInitialDuration.Request) {
    worker?.getDuration { [weak self] (duration) in
      let setDurationRequest = CreateSession.SetDuration.Request(duration: duration)
      self?.setDuration(request: setDurationRequest)
    }
  }
  
  func setDuration(request: CreateSession.SetDuration.Request) {
    if !request.duration.isValid {
      setDefaultDuration()
    } else {
      worker?.setDuration(request.duration) { [weak self] _ in
        let response = CreateSession.SetDuration.Response(duration: request.duration)
        self?.sessionDuration = request.duration
        self?.presenter.presentSetDuration(response: response)
      }
    }
  }
  
  private func setDefaultDuration() {
    worker?.getDefaultDuration { [weak self] (duration) in
      self?.worker?.setDuration(duration) { [weak self] _ in
        let response = CreateSession.SetDuration.Response(duration: duration)
        self?.sessionDuration = duration
        self?.presenter.presentSetDuration(response: response)
      }
    }
  }
}
