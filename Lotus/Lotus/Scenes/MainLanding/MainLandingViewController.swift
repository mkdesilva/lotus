//
//  MainLandingViewController.swift
//  Lotus
//
//  Created by Mihindu de Silva on 5/3/20.
//  Copyright (c) 2020 Mihindu de Silva. All rights reserved.
//

import UIKit

protocol MainLandingViewControllerInterface: class {
}

class MainLandingViewController: UITabBarController, MainLandingViewControllerInterface {
  
  let createSessionViewController = CreateSessionViewController()
  
  // MARK: - Configuration
  
  private func setTabBarItems() {
    guard let items = tabBar.items else { return }
    items[0].title = "Meditate"
    items[0].image = Assets.ring.image
  }
  
  // MARK: - View lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    viewControllers = [createSessionViewController]
    setTabBarItems()
    selectedViewController = createSessionViewController
  }
  
}
