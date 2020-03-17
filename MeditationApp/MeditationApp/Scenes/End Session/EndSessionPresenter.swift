//
//  EndSessionPresenter.swift
//  MeditationApp
//
//  Created by Mihindu de Silva on 5/3/20.
//  Copyright (c) 2020 Mihindu de Silva. All rights reserved.
//

import UIKit

protocol EndSessionPresenterInterface {
  func presentSomething(response: EndSession.Something.Response)
}

class EndSessionPresenter: EndSessionPresenterInterface {
  weak var viewController: EndSessionViewControllerInterface!

  // MARK: - Presentation logic

  func presentSomething(response: EndSession.Something.Response) {
    let viewModel = EndSession.Something.ViewModel()
    viewController.displaySomething(viewModel: viewModel)
  }
}
