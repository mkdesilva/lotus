//
//  EndSessionModels.swift
//  Lotus
//
//  Created by Mihindu de Silva on 5/3/20.
//  Copyright (c) 2020 Mihindu de Silva. All rights reserved.
//

import UIKit

struct EndSession {
  struct GetSessionStats {
    struct Request {
    }
    struct Response {
      let result: Result<SessionStats, CustomError>
    }
    struct ViewModel {
      let content: Content<String>
    }
  }
  
  struct GetQuote {
    struct Request {
    }
    struct Response {
      let result: Result<Quote, CustomError>
    }
    struct ViewModel {
      let content: Content<String>
    }
  }
}
