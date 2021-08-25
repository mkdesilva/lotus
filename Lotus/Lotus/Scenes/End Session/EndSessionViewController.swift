//
//  EndSessionViewController.swift
//  Lotus
//
//  Created by Mihindu de Silva on 5/3/20.
//  Copyright (c) 2020 Mihindu de Silva. All rights reserved.
//

import UIKit

protocol EndSessionViewControllerInterface: AnyObject {
  func displayGetSessionStats(viewModel: EndSession.GetSessionStats.ViewModel)
  func displayGetQuote(viewModel: EndSession.GetQuote.ViewModel)
}

protocol EndSessionDelegate: AnyObject {
  func closeView()
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
    
    viewController.interactor = interactor
    viewController.router = router
  }
  
  // MARK: - View lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    createView()
    saveSessionStats()
    getSessionStats()
    getQuote()
  }
  
  var endSessionView: EndSessionView!
  
  private func createView() {
    endSessionView = EndSessionView(frame: view.frame)
    view.addSubview(endSessionView)
    endSessionView.setup(delegate: self)
  }
  
  // MARK: - Event handling
  
  private func getSessionStats() {
    let request = EndSession.GetSessionStats.Request()
    interactor.getSessionStats(request: request)
  }
  
  private func saveSessionStats() {
    let request = EndSession.SaveSessionStats.Request()
    interactor.saveSessionStats(request: request)
  }
  
  private func getQuote() {
    let request = EndSession.GetQuote.Request()
    interactor.getQuote(request: request)
  }
  
  // MARK: - Display logic
  
  func displayGetSessionStats(viewModel: EndSession.GetSessionStats.ViewModel) {
    switch viewModel.content {
    case .customError:
      return
    case .success(data: let text):
      endSessionView.displayStats(durationText: text)
    }
  }
  
  func displayGetQuote(viewModel: EndSession.GetQuote.ViewModel) {
    switch viewModel.content {
    case .customError:
      endSessionView.displayQuote(text: "")
      return
    case .success(data: let data):
      endSessionView.displayQuote(text: data)
    }
  }

  // MARK: - Router
}

extension EndSessionViewController: EndSessionDelegate {
  func closeView() {
    self.router.navigateToLanding()
  }
}
