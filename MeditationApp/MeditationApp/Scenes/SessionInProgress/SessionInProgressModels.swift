//
//  SessionInProgressModels.swift
//  MeditationApp
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
      var duration: Duration
    }
    
    struct ViewModel {
      let durationText: String
    }
  }
}
