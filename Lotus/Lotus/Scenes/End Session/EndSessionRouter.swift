//
//  EndSessionRouter.swift
//  Lotus
//
//  Created by Mihindu de Silva on 5/3/20.
//  Copyright (c) 2020 Mihindu de Silva. All rights reserved.
//

import UIKit

protocol EndSessionRouterInterface {
  func navigateToLanding()
}

class EndSessionRouter: EndSessionRouterInterface {
  weak var viewController: EndSessionViewController!
  
  // MARK: - Navigation
  
  func navigateToLanding() {
    let destinationVc = MainLandingViewController()
    viewController.modalPresentationStyle = .fullScreen
    viewController.navigationController?.setViewControllers([destinationVc], animated: false)
    destinationVc.awakeFromNib()
  }
}
