//
//  EndSessionViewController.swift
//  MeditationApp
//
//  Created by Mihindu de Silva on 5/3/20.
//  Copyright (c) 2020 Mihindu de Silva. All rights reserved.
//

import UIKit

protocol EndSessionViewControllerInterface: class {
  func displaySomething(viewModel: EndSession.Something.ViewModel)
}

protocol EndSessionDelegate: class {
}

class EndSessionViewController: UIViewController, EndSessionViewControllerInterface {
  var interactor: EndSessionInteractorInterface!
  var router: EndSessionRouterInterface!
  
  // MARK: - Object lifecycle
  
  override func awakeFromNib() {
    super.awakeFromNib()
    configure(viewController: self)
  }
  
  // MARK: - Configuration
  
  private func configure(viewController: EndSessionViewController) {
    let router = EndSessionRouter()
    router.viewController = viewController
    
    let presenter = EndSessionPresenter()
    presenter.viewController = viewController
    
    let interactor = EndSessionInteractor()
    interactor.presenter = presenter
    interactor.worker = EndSessionWorker(store: EndSessionStore())
    
    viewController.interactor = interactor
    viewController.router = router
  }
  
  // MARK: - View lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configure(viewController: self)
    createView()
    doSomethingOnLoad()
  }
  
  private func createView() {
    let endSessionView = EndSessionView(frame: view.frame)
    view.addSubview(endSessionView)
    endSessionView.setup(delegate: self)
  }
  
  // MARK: - Event handling
  
  func doSomethingOnLoad() {
    // NOTE: Ask the Interactor to do some work
    
    let request = EndSession.Something.Request()
    interactor.doSomething(request: request)
  }
  
  // MARK: - Display logic
  
  func displaySomething(viewModel: EndSession.Something.ViewModel) {
    // NOTE: Display the result from the Presenter
    
    // nameTextField.text = viewModel.name
  }
  
  // MARK: - Router
}

extension EndSessionViewController: EndSessionDelegate {
  
}

extension EndSessionViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
  func pageViewController(_ pageViewController: UIPageViewController,
                          viewControllerBefore viewController: UIViewController) -> UIViewController? {
    return UIViewController()
  }
  
  func pageViewController(_ pageViewController: UIPageViewController,
                          viewControllerAfter viewController: UIViewController) -> UIViewController? {
    return UIViewController()
  }
}
