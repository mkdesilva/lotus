//
//  SessionInProgressPresenter.swift
//  MeditationApp
//
//  Created by Mihindu de Silva on 17/1/20.
//  Copyright (c) 2020 Mihindu de Silva. All rights reserved.
//

import UIKit

protocol SessionInProgressPresenterInterface {
  func presentDuration(response: SessionInProgress.UpdateDuration.Response)
}

class SessionInProgressPresenter: SessionInProgressPresenterInterface {
  weak var viewController: SessionInProgressViewControllerInterface!
  
  // MARK: - Presentation logic
  
  func presentDuration(response: SessionInProgress.UpdateDuration.Response) {
    var durationText = ""
    let formattedMinutes = String(format: "%02d", response.duration.minutes)
    let formattedSeconds = String(format: "%02d", response.duration.seconds)
    
    if response.duration.hours == 0 {
      durationText = "\(formattedMinutes):\(formattedSeconds)"
    } else {
      durationText = "\(response.duration.hours):\(formattedMinutes):\(formattedSeconds)"
    }
    
    let viewModel = SessionInProgress.UpdateDuration.ViewModel(durationText: durationText)
    viewController.displayDuration(viewModel: viewModel)
  }
}
