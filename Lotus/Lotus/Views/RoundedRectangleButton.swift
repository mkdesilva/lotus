//
//  RoundedRectangleButton.swift
//  Lotus
//
//  Created by Mihindu de Silva on 5/3/20.
//  Copyright © 2020 Mihindu de Silva. All rights reserved.
//

import UIKit

class RoundedRectangleButton: UIButton {
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    translatesAutoresizingMaskIntoConstraints = false
    heightAnchor.constraint(equalToConstant: 67).isActive = true
    widthAnchor.constraint(equalToConstant: 170).isActive = true
    layer.cornerRadius = 30
    titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
    backgroundColor = Colors.slateBlue.color
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    translatesAutoresizingMaskIntoConstraints = false
    heightAnchor.constraint(equalToConstant: 50).isActive = true
    widthAnchor.constraint(equalToConstant: 150).isActive = true
    layer.cornerRadius = 15
    titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
    backgroundColor = Colors.slateBlue.color
  }
}
