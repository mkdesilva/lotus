//
//  SessionInProgressStore.swift
//  MeditationApp
//
//  Created by Mihindu de Silva on 17/1/20.
//  Copyright (c) 2020 Mihindu de Silva. All rights reserved.
//

import Foundation

class SessionInProgressStore: SessionInProgressStoreProtocol {
  func getData(_ completion: @escaping (Result<Session, Error>) -> Void) {
    completion(Result.success(Session(initialDuration: Duration(hours: 1, minutes: 0))))
  }
}
