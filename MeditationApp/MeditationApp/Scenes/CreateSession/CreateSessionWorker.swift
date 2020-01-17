//
//  CreateSessionWorker.swift
//  MeditationApp
//
//  Created by Mihindu de Silva on 8/11/19.
//  Copyright (c) 2019 Mihindu de Silva. All rights reserved.
//

import UIKit

class CreateSessionWorker {
  
  var store: CreateSessionStoreProtocol
  
  init(store: CreateSessionStoreProtocol) {
    self.store = store
  }
  
  // MARK: - Business Logic
  
  func getDuration(completion: @escaping (Duration) -> Void) {
    store.getDuration(completion)
  }
  
  func setDuration(_ duration: Duration, completion: @escaping (Result<Duration, CustomError>) -> Void) {
    store.setDuration(duration: duration, completion)
  }
  
  func getDefaultDuration(completion: @escaping (Duration) -> Void) {
    store.getDefaultDuration(completion: completion)
  }
}
