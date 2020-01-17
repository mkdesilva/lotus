//
//  CreateSessionRouter.swift
//  MeditationApp
//
//  Created by Mihindu de Silva on 8/11/19.
//  Copyright (c) 2019 Mihindu de Silva. All rights reserved.
//

import UIKit

protocol CreateSessionRouterInput {
  func navigateToDurationPicker(duration: Duration?)
  func navigateToInProgressScene(duration: Duration)
}

class CreateSessionRouter: CreateSessionRouterInput {
  
  weak var viewController: CreateSessionViewController!
  
  func navigateToDurationPicker(duration: Duration?) {
    let durationPickerViewController = DurationPickerViewController()
    durationPickerViewController.initialDuration = duration
    durationPickerViewController.delegate = viewController
    viewController.present(durationPickerViewController, animated: true)
  }
  
  func navigateToInProgressScene(duration: Duration) {
    let initialVc = Storyboards.sessionInProgress.instantiateInitialViewController()
    guard let inProgressViewController = initialVc as? SessionInProgressViewController else { return }
    inProgressViewController.interactor.sessionDuration = duration
    viewController.navigationController?.setViewControllers([inProgressViewController], animated: false)
  }
}
