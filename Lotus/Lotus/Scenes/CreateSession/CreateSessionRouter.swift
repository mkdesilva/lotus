//
//  CreateSessionRouter.swift
//  Lotus
//
//  Created by Mihindu de Silva on 8/11/19.
//  Copyright (c) 2019 Mihindu de Silva. All rights reserved.
//

import UIKit

protocol CreateSessionRouterInterface {
  func navigateToDurationPicker(duration: SessionDuration?)
  func navigateToInProgressScene(duration: SessionDuration)
}

class CreateSessionRouter: CreateSessionRouterInterface {
  
  weak var viewController: CreateSessionViewController!
  
  func navigateToDurationPicker(duration: SessionDuration?) {
    let durationPickerViewController = DurationPickerViewController()
    durationPickerViewController.initialDuration = duration
    durationPickerViewController.delegate = viewController
    viewController.present(durationPickerViewController, animated: true)
  }
  
  func navigateToInProgressScene(duration: SessionDuration) {
    let initialVc = Storyboards.sessionInProgress.instantiateInitialViewController()
    guard let inProgressViewController = initialVc as? SessionInProgressViewController else { return }
    
    inProgressViewController.awakeFromNib()
    
    inProgressViewController.interactor.session = Session(initialDuration: duration)
    viewController.navigationController?.setViewControllers([inProgressViewController], animated: false)
  }
}
