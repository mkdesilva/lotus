//
//  SessionInProgressWorker.swift
//  Lotus
//
//  Created by Mihindu de Silva on 17/1/20.
//  Copyright (c) 2020 Mihindu de Silva. All rights reserved.
//

import UIKit

protocol SessionInProgressStoreProtocol {
  func getData(_ completion: @escaping (Result<Session, Error>) -> Void)
}

class SessionInProgressWorker {

  var store: SessionInProgressStoreProtocol

  init(store: SessionInProgressStoreProtocol) {
    self.store = store
  }

  // MARK: - Business Logic

  func doSomeWork(_ completion: @escaping (Result<Session, Error>) -> Void) {
    // NOTE: Do the work
    store.getData {
      // The worker may perform some small business logic before returning the result to the Interactor
      completion($0)
    }
  }
}
