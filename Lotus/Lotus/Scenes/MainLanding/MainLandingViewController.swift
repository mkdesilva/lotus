//
//  MainLandingViewController.swift
//  Lotus
//
//  Created by Mihindu de Silva on 5/3/20.
//  Copyright (c) 2020 Mihindu de Silva. All rights reserved.
//

import UIKit

protocol MainLandingViewControllerInterface: AnyObject {
}

class MainLandingViewController: UITabBarController, MainLandingViewControllerInterface {
  
  let createSessionViewController = CreateSessionViewController()
  let historyViewController = HistoryViewController()
  
  // MARK: - Configuration
  
  private func setTabBarItems() {
    guard let items = tabBar.items else { return }
    items[0].title = "Meditate"
    items[0].image = Assets.ring.image
    items[1].title = "History"
    
    let image = UIImage(systemName: "clock")
    items[1].image = image
  }
  
  // MARK: - View lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    viewControllers = [createSessionViewController, historyViewController]
    setTabBarItems()
    selectedViewController = createSessionViewController
  }
  
}
