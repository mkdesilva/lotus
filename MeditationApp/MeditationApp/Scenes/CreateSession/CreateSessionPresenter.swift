//
//  CreateSessionPresenter.swift
//  MeditationApp
//
//  Created by Mihindu de Silva on 8/11/19.
//  Copyright (c) 2019 Mihindu de Silva. All rights reserved.
//

import UIKit

protocol CreateSessionPresenterInterface {
  func presentSetDuration(response: CreateSession.SetDuration.Response)
}

class CreateSessionPresenter: CreateSessionPresenterInterface {
  weak var viewController: CreateSessionViewControllerInterface!
  
  // MARK: - Presentation logic
  
  func presentSetDuration(response: CreateSession.SetDuration.Response) {
    var durationString = ""
    
    if response.duration.hours == 0 {
      durationString = "\(response.duration.minutes)m"
    } else if response.duration.minutes == 0 {
      durationString = "\(response.duration.hours)h"
    } else {
      durationString = "\(response.duration.hours)h \(response.duration.minutes)m"
    }
    
    let viewModel = CreateSession.SetDuration.ViewModel(durationTitle: durationString)
    viewController.displaySetDuration(viewModel: viewModel)
  }
  
}
