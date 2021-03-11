//
//  EndSessionPresenter.swift
//  Lotus
//
//  Created by Mihindu de Silva on 5/3/20.
//  Copyright (c) 2020 Mihindu de Silva. All rights reserved.
//

import UIKit

protocol EndSessionPresenterInterface {
  func presentGetSessionStats(response: EndSession.GetSessionStats.Response)
  func presentGetQuote(response: EndSession.GetQuote.Response)
}

class EndSessionPresenter: EndSessionPresenterInterface {
  weak var viewController: EndSessionViewControllerInterface!

  // MARK: - Presentation logic

  func presentGetSessionStats(response: EndSession.GetSessionStats.Response) {
    var viewModel: EndSession.GetSessionStats.ViewModel!
    
    switch response.result {
    case .failure(let error):
      viewModel = EndSession.GetSessionStats.ViewModel(content: .customError(error))
    case .success(let stats):
      viewModel = EndSession.GetSessionStats.ViewModel(content: .success(data: stats.duration.fullDescription))
    }
        
    viewController.displayGetSessionStats(viewModel: viewModel)
  }
  
  func presentGetQuote(response: EndSession.GetQuote.Response) {
    var viewModel: EndSession.GetQuote.ViewModel
    
    switch response.result {
    case .failure(let error):
      viewModel = EndSession.GetQuote.ViewModel(content: .customError(error))
    case .success(let quote):
      
      let data = "\"\(quote.text)\"\n  -\(quote.author)"
      
      viewModel = EndSession.GetQuote.ViewModel(content: .success(data: data))
    }
    
    viewController.displayGetQuote(viewModel: viewModel)
    
  }
  
}
