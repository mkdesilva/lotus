//
//  SessionInProgressEntity.swift
//  MeditationApp
//
//  Created by Mihindu de Silva on 17/1/20.
//  Copyright (c) 2020 Mihindu de Silva. All rights reserved.
//

import Foundation

struct Session {
  let initialDuration: SessionDuration
  var remainingDuration: SessionDuration
  var isInProgress = false
  
  init(initialDuration: SessionDuration) {
    self.initialDuration = initialDuration
    self.remainingDuration = initialDuration
  }
}
