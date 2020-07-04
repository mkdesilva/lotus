//
//  CreateSessionViewController.swift
//  Lotus
//
//  Created by Mihindu de Silva on 8/11/19.
//  Copyright (c) 2019 Mihindu de Silva. All rights reserved.
//

import UIKit

protocol CreateSessionViewControllerDelegate: class {
  func didSelectDuration(duration: SessionDuration)
  func showDurationPicker()
  func beginSession()
}

protocol CreateSessionViewControllerInterface: class {
  func displaySetDuration(viewModel: CreateSession.SetDuration.ViewModel)
}

class CreateSessionViewController: UIViewController, CreateSessionViewControllerInterface {
  
  var interactor: CreateSessionInteractorInterface!
  var router: CreateSessionRouterInterface!
  var createSessionView: CreateSessionView!
  
  // MARK: - Configuration
  
  private func configure(viewController: CreateSessionViewController) {
    let router = CreateSessionRouter()
    router.viewController = viewController
    
    let presenter = CreateSessionPresenter()
    presenter.viewController = viewController
    
    let interactor = CreateSessionInteractor()
    interactor.presenter = presenter
    interactor.worker = CreateSessionWorker(store: CreateSessionStore())
    
    viewController.interactor = interactor
    viewController.router = router
  }
  
  // MARK: - View lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configure(viewController: self)
    createView()
    
    getInitialDuration()
  }
  
  private func createView() {
    let blurredBackgroundView = BlurredBackgroundView(image: Assets.lake.image)
    view.addSubview(blurredBackgroundView)
    createSessionView = CreateSessionView()
    view.addSubview(createSessionView)
    createSessionView.setup()
    createSessionView.delegate = self
  }
  
  func getInitialDuration() {
    let request = CreateSession.GetInitialDuration.Request()
    interactor.getInitialDuration(request: request)
  }
  
  // MARK: - Display logic
  
  func displaySetDuration(viewModel: CreateSession.SetDuration.ViewModel) {
    createSessionView.displayDuration(durationTitle: viewModel.durationTitle)
  }
}

extension CreateSessionViewController: CreateSessionViewControllerDelegate {
  
  // MARK: - Event handling
  
  func didSelectDuration(duration: SessionDuration) {
    let request = CreateSession.SetDuration.Request(duration: duration)
    interactor.setDuration(request: request)
  }
  
  func beginSession() {
    guard let duration = interactor.sessionDuration else {  return }
    routeToBeginSession(duration: duration)
  }
  
  // MARK: - Router
  
  func showDurationPicker() {
    router.navigateToDurationPicker(duration: interactor.sessionDuration)
  }
  
  func routeToBeginSession(duration: SessionDuration) {
    router.navigateToInProgressScene(duration: duration)
  }
}
