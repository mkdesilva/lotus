//
//  CreateSessionPresenter.swift
//  Lotus
//
//  Created by Mihindu de Silva on 8/11/19.
//  Copyright (c) 2019 Mihindu de Silva. All rights reserved.
//

import UIKit

protocol CreateSessionPresenterInterface {
  func presentInitialDuration(response: CreateSession.ShowDuration.Response)
}

class CreateSessionPresenter: CreateSessionPresenterInterface {
  weak var viewController: CreateSessionViewControllerInterface!
  
  // MARK: - Presentation logic
  
  func presentInitialDuration(response: CreateSession.ShowDuration.Response) {
    let viewModel = CreateSession.ShowDuration.ViewModel(hours: response.duration.hours, minutes: response.duration.minutes, seconds: response.duration.seconds)
    viewController.displayInitialDuration(viewModel: viewModel)
  }
  
}
