//
//  SessionInProgressEntity.swift
//  MeditationApp
//
//  Created by Mihindu de Silva on 17/1/20.
//  Copyright (c) 2020 Mihindu de Silva. All rights reserved.
//

import Foundation

struct Session {
  let initialDuration: Duration
  var currentDuration: Duration
  var isInProgress = false
  
  init(initialDuration: Duration) {
    self.initialDuration = initialDuration
    self.currentDuration = initialDuration
  }
}
