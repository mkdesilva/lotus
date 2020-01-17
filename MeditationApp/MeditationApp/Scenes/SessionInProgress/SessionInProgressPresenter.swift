//
//  SessionInProgressPresenter.swift
//  MeditationApp
//
//  Created by Mihindu de Silva on 17/1/20.
//  Copyright (c) 2020 Mihindu de Silva. All rights reserved.
//

import UIKit

protocol SessionInProgressPresenterInterface {
  func presentSomething(response: SessionInProgress.Something.Response)
}

class SessionInProgressPresenter: SessionInProgressPresenterInterface {
  weak var viewController: SessionInProgressViewControllerInterface!

  // MARK: - Presentation logic

  func presentSomething(response: SessionInProgress.Something.Response) {
    
    let viewModel = SessionInProgress.Something.ViewModel()
    viewController.displaySomething(viewModel: viewModel)
  }
}
