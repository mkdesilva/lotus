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
    
    let viewModel = CreateSession.SetDuration.ViewModel(durationTitle: response.duration.description)
    viewController.displaySetDuration(viewModel: viewModel)
  }
  
}
