//
//  SessionInProgressModels.swift
//  Lotus
//
//  Created by Mihindu de Silva on 17/1/20.
//  Copyright (c) 2020 Mihindu de Silva. All rights reserved.
//

import UIKit

struct SessionInProgress {
  struct GetInitialDuration {
    struct Request {}
  }
  
  struct StartSession {
    struct Request {}
    struct Response {}
    struct ViewModel {}
  }
  
  struct UpdateDuration {
    struct Request {
      let timeInterval: Int
    }
    
    struct Response {
      let duration: SessionDuration
    }
    
    struct ViewModel {
      let durationText: String
    }
  }
  
  struct TogglePause {
    struct Request {}
    struct Response {
      let isPaused: Bool
    }
    struct ViewModel {
      let isPaused: Bool
    }
  }
  
  struct EndSession {
    struct Request {
      let playEndSound: Bool
    }
    struct Response {
      let sessionStats: SessionStats
      let playEndSound: Bool
    }
    struct ViewModel {
      let sessionStats: SessionStats
      let playEndSound: Bool
    }
  }
}
