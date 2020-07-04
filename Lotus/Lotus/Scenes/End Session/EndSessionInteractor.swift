//
//  EndSessionInteractor.swift
//  Lotus
//
//  Created by Mihindu de Silva on 5/3/20.
//  Copyright (c) 2020 Mihindu de Silva. All rights reserved.
//

import UIKit

protocol EndSessionInteractorInterface {
  func getSessionStats(request: EndSession.GetSessionStats.Request)
  var sessionStats: SessionStats? { get set }
}

class EndSessionInteractor: EndSessionInteractorInterface {
  var presenter: EndSessionPresenterInterface!
  var sessionStats: SessionStats?
  
  // MARK: - Business logic
  
  func getSessionStats(request: EndSession.GetSessionStats.Request) {
    guard let stats = sessionStats else {
      let response = EndSession.GetSessionStats.Response(result: .failure(.generic))
      self.presenter.presentGetSessionStats(response: response)
      return
    }
    
    let response = EndSession.GetSessionStats.Response(result: .success(stats))
    self.presenter.presentGetSessionStats(response: response)
  }
}
