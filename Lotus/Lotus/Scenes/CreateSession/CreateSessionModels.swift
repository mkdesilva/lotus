//
//  CreateSessionModels.swift
//  Lotus
//
//  Created by Mihindu de Silva on 8/11/19.
//  Copyright (c) 2019 Mihindu de Silva. All rights reserved.
//

import UIKit

struct CreateSession {
  
  struct GetInitialDuration {
    struct Request {}
    
    struct Response {
      let duration: SessionDuration
    }
    
    struct ViewModel {
      let duration: SessionDuration
    }
  }
  
  struct SetDuration {
    struct Request {
      let duration: SessionDuration
    }
    struct Response {
      let duration: SessionDuration
    }
    
    struct ViewModel {
      let hours: Int
      let minutes: Int
      let seconds: Int
    }
  }
  
  struct StoreDuration {
    struct Request {
      let duration: SessionDuration
    }
  }
}
