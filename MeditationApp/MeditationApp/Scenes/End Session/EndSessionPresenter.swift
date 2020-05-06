//
//  EndSessionPresenter.swift
//  MeditationApp
//
//  Created by Mihindu de Silva on 5/3/20.
//  Copyright (c) 2020 Mihindu de Silva. All rights reserved.
//

import UIKit

protocol EndSessionPresenterInterface {
  func presentGetSessionStats(response: EndSession.GetSessionStats.Response)
}

class EndSessionPresenter: EndSessionPresenterInterface {
  weak var viewController: EndSessionViewControllerInterface!

  // MARK: - Presentation logic

  func presentGetSessionStats(response: EndSession.GetSessionStats.Response) {
    var viewModel: EndSession.GetSessionStats.ViewModel!
    
    switch response.result {
    case .failure(let error):
      viewModel = EndSession.GetSessionStats.ViewModel(content: .customError(error))
    case .success(let stats):
      viewModel = EndSession.GetSessionStats.ViewModel(content: .success(data: stats.duration.fullDescription))
    }
        
    viewController.displayGetSessionStats(viewModel: viewModel)
  }
}
