//
//  CreateSessionInteractor.swift
//  Lotus
//
//  Created by Mihindu de Silva on 8/11/19.
//  Copyright (c) 2019 Mihindu de Silva. All rights reserved.
//

import UIKit

protocol CreateSessionInteractorInterface {
  func getInitialDuration(request: CreateSession.GetInitialDuration.Request)
  func storeDuration(request: CreateSession.StoreDuration.Request)
  var sessionDuration: SessionDuration? { get set }
}

class CreateSessionInteractor: CreateSessionInteractorInterface {
  
  var presenter: CreateSessionPresenterInterface!
  var worker: CreateSessionWorker?
  
  var sessionDuration: SessionDuration?
  
  // MARK: - Business logic
  
  func getInitialDuration(request: CreateSession.GetInitialDuration.Request) {
    worker?.getDuration { [weak self] (duration) in
      let setDurationRequest = CreateSession.ShowDuration.Request(duration: duration)
      self?.showDuration(request: setDurationRequest)
    }
  }
  
  private func showDuration(request: CreateSession.ShowDuration.Request) {
    guard request.duration.isValid else {
      setDefaultDuration()
      return
    }
    
    worker?.setDuration(request.duration) { [weak self] _ in
      guard let self = self else { return }
      let response = CreateSession.ShowDuration.Response(duration: request.duration)
      self.sessionDuration = request.duration
      self.presenter.presentInitialDuration(response: response)
    }
  }
  
  func storeDuration(request: CreateSession.StoreDuration.Request) {
    guard request.duration.isValid else { return }
    worker?.setDuration(request.duration, completion: {_ in })
  }
  
  private func setDefaultDuration() {
    worker?.getDefaultDuration { [weak self] (duration) in
      self?.worker?.setDuration(duration) { [weak self] _ in
        let response = CreateSession.ShowDuration.Response(duration: duration)
        self?.sessionDuration = duration
        self?.presenter.presentInitialDuration(response: response)
      }
    }
  }
}
