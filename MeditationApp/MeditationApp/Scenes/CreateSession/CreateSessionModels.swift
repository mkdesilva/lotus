//
//  CreateSessionModels.swift
//  MeditationApp
//
//  Created by Mihindu de Silva on 8/11/19.
//  Copyright (c) 2019 Mihindu de Silva. All rights reserved.
//

import UIKit

struct CreateSession {
  
  struct GetInitialDuration {
    struct Request {}
    
    struct Response {
      let duration: Duration
    }
    
    struct ViewModel {
      let duration: Duration
    }
  }
  
  struct SetDuration {
    
    struct Request {
      let duration: Duration
    }
    
    struct Response {
      let duration: Duration
    }
    
    struct ViewModel {
      let durationTitle: String
    }
  }
}
