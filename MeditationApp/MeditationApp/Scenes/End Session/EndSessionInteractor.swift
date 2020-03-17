//
//  EndSessionInteractor.swift
//  MeditationApp
//
//  Created by Mihindu de Silva on 5/3/20.
//  Copyright (c) 2020 Mihindu de Silva. All rights reserved.
//

import UIKit

protocol EndSessionInteractorInterface {
  func doSomething(request: EndSession.Something.Request)
  var model: Entity? { get }
}

class EndSessionInteractor: EndSessionInteractorInterface {
  var presenter: EndSessionPresenterInterface!
  var worker: EndSessionWorker?
  var model: Entity?

  // MARK: - Business logic

  func doSomething(request: EndSession.Something.Request) {
    worker?.doSomeWork { [weak self] in
      if case let Result.success(data) = $0 {
        // If the result was successful, we keep the data so that we can deliver it to another view controller through the router.
        self?.model = data
      }

      let response = EndSession.Something.Response()
      self?.presenter.presentSomething(response: response)
    }
  }
}
