//
//  SessionInProgressInteractor.swift
//  MeditationApp
//
//  Created by Mihindu de Silva on 17/1/20.
//  Copyright (c) 2020 Mihindu de Silva. All rights reserved.
//

import UIKit

protocol SessionInProgressInteractorInterface {
  func doSomething(request: SessionInProgress.Something.Request)
  var session: Session? { get }
  var sessionDuration: Duration! { get set }
}

class SessionInProgressInteractor: SessionInProgressInteractorInterface {
  var presenter: SessionInProgressPresenterInterface!
  var worker: SessionInProgressWorker?
  var session: Session?
  var sessionDuration: Duration!

  // MARK: - Business logic

  func doSomething(request: SessionInProgress.Something.Request) {
    worker?.doSomeWork { [weak self] in
      if case let Result.success(data) = $0 {
        self?.session = data
      }

      let response = SessionInProgress.Something.Response()
      self?.presenter.presentSomething(response: response)
    }
  }
}
