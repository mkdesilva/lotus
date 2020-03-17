//
//  SessionInProgressRouter.swift
//  MeditationApp
//
//  Created by Mihindu de Silva on 17/1/20.
//  Copyright (c) 2020 Mihindu de Silva. All rights reserved.
//

import UIKit

protocol SessionInProgressRouterInterface {
  func navigateToEndSession()
}

class SessionInProgressRouter: SessionInProgressRouterInterface {
  weak var viewController: SessionInProgressViewController!

  // MARK: - Navigation

  func navigateToEndSession() {
    let endSessionVc = EndSessionViewController()
    print("navigating")
    viewController.modalPresentationStyle = .fullScreen

    viewController.navigationController?.setViewControllers([endSessionVc], animated: false)

  }

  // MARK: - Communication

//  func passDataToNextScene(viewController: EndSessionViewController) {
//
//
//  }

}
