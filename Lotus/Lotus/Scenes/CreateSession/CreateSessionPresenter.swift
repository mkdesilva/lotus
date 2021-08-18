//
//  CreateSessionPresenter.swift
//  Lotus
//
//  Created by Mihindu de Silva on 8/11/19.
//  Copyright (c) 2019 Mihindu de Silva. All rights reserved.
//

import UIKit

protocol CreateSessionPresenterInterface {
  func presentInitialDuration(response: CreateSession.SetDuration.Response)
}

class CreateSessionPresenter: CreateSessionPresenterInterface {
  weak var viewController: CreateSessionViewControllerInterface!
  
  // MARK: - Presentation logic
  
  func presentInitialDuration(response: CreateSession.SetDuration.Response) {
    
    let viewModel = CreateSession.SetDuration.ViewModel(durationTitle: response.duration.description)
    viewController.displayInitialDuration(viewModel: viewModel)
  }
  
}
