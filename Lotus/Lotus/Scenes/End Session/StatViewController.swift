//
//  StatViewController.swift
//  Lotus
//
//  Created by Mihindu de Silva on 11/3/20.
//  Copyright © 2020 Mihindu de Silva. All rights reserved.
//

import UIKit

class StatViewController: UIViewController {
  
  private var titleLabel: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    titleLabel = UILabel(frame: view.frame)
    
    view.addSubview(titleLabel)
  }
  
  func setupUI(title: String) {
    titleLabel.text = title
  }
  
}
