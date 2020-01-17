//
//  SessionInProgressViewController.swift
//  MeditationApp
//
//  Created by Mihindu de Silva on 17/1/20.
//  Copyright (c) 2020 Mihindu de Silva. All rights reserved.
//

import UIKit

protocol SessionInProgressViewControllerInterface: class {
  func displaySomething(viewModel: SessionInProgress.Something.ViewModel)
}

class SessionInProgressViewController: UIViewController, SessionInProgressViewControllerInterface {
  var interactor: SessionInProgressInteractorInterface!
  var router: SessionInProgressRouter!

  // MARK: - Object lifecycle

  override func awakeFromNib() {
    super.awakeFromNib()
    configure(viewController: self)
  }

  // MARK: - Configuration

  private func configure(viewController: SessionInProgressViewController) {
    let router = SessionInProgressRouter()
    router.viewController = viewController

    let presenter = SessionInProgressPresenter()
    presenter.viewController = viewController

    let interactor = SessionInProgressInteractor()
    interactor.presenter = presenter
    interactor.worker = SessionInProgressWorker(store: SessionInProgressStore())

    viewController.interactor = interactor
    viewController.router = router
  }

  // MARK: - View lifecycle

  override func viewDidLoad() {
    super.viewDidLoad()
    createView()
  }
  
  private func createView() {
    let inProgressView = SessionInProgressView()
    view.addSubview(inProgressView)
    inProgressView.setup()
  }
  
  // MARK: - Event handling

  func doSomethingOnLoad() {
    // NOTE: Ask the Interactor to do some work

    let request = SessionInProgress.Something.Request()
    interactor.doSomething(request: request)
    
  }

  // MARK: - Display logic

  func displaySomething(viewModel: SessionInProgress.Something.ViewModel) {
    // NOTE: Display the result from the Presenter

    // nameTextField.text = viewModel.name
  }

  // MARK: - Router

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    router.passDataToNextScene(segue: segue)
  }

  @IBAction func unwindToSessionInProgressViewController(from segue: UIStoryboardSegue) {
    print("unwind...")
    router.passDataToNextScene(segue: segue)
  }
}
