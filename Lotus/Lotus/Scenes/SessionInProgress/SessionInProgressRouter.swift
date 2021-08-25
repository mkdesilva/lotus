//
//  SessionInProgressRouter.swift
//  Lotus
//
//  Created by Mihindu de Silva on 17/1/20.
//  Copyright (c) 2020 Mihindu de Silva. All rights reserved.
//

import UIKit

protocol SessionInProgressRouterInterface {
  func navigateToEndSession(sessionStats: SessionStats)
}

class SessionInProgressRouter: SessionInProgressRouterInterface {
  weak var viewController: SessionInProgressViewController!
  
  // MARK: - Navigation
  
  func navigateToEndSession(sessionStats: SessionStats) {
    let endSessionVc = EndSessionViewController()
    viewController.modalPresentationStyle = .fullScreen
    viewController.navigationController?.setViewControllers([endSessionVc], animated: false)
    endSessionVc.awakeFromNib()
    endSessionVc.interactor.sessionStats = sessionStats
  }
}
