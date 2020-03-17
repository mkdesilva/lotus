//
//  EndSessionWorker.swift
//  MeditationApp
//
//  Created by Mihindu de Silva on 5/3/20.
//  Copyright (c) 2020 Mihindu de Silva. All rights reserved.
//

import UIKit

protocol EndSessionStoreProtocol {
  func getData(_ completion: @escaping (Result<Entity, Error>) -> Void)
}

class EndSessionWorker {

  var store: EndSessionStoreProtocol

  init(store: EndSessionStoreProtocol) {
    self.store = store
  }

  // MARK: - Business Logic

  func doSomeWork(_ completion: @escaping (Result<Entity, Error>) -> Void) {
    // NOTE: Do the work
    store.getData {
      // The worker may perform some small business logic before returning the result to the Interactor
      completion($0)
    }
  }
}
