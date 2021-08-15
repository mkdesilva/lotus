//
//  BeginButton.swift
//  Lotus
//
//  Created by Mihindu de Silva on 18/12/19.
//  Copyright © 2019 Mihindu de Silva. All rights reserved.
//

import UIKit

class BeginButton: UIButton, CustomView {
  
  var createSessionView: CreateSessionView?
  
  func setup() {
    setup(size: UIScreen.main.bounds.height / 3)
  }
  
  func setup(size: CGFloat) {
    translatesAutoresizingMaskIntoConstraints = false
    backgroundColor = Colors.darkBlack.color
    widthAnchor.constraint(equalToConstant: size).isActive = true
    heightAnchor.constraint(equalToConstant: size).isActive = true
    layer.cornerRadius = size / 2
    clipsToBounds = true
    addTarget(self, action: #selector(tappedBegin), for: .touchUpInside)
    
    let startLabel = UILabel()
    addSubview(startLabel)
    startLabel.text = "Start"
    startLabel.textAlignment = .center
    startLabel.translatesAutoresizingMaskIntoConstraints = false
    startLabel.textColor = Colors.slateBlue.color
    startLabel.addConstraints(topSpacing: 0, leadingSpacing: 0, trailingSpacing: 0, bottomSpacing: 0)
  }
  
  @objc func tappedBegin() {
    guard let delegate = createSessionView else { return }
    delegate.tappedBegin()
  }
}

extension BeginButton {
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    let radius = frame.width / 2
    var point: CGPoint = CGPoint()
    
    if let touch = touches.first {
      point = touch.location(in: self.superview)
    }
    
    let distance = sqrt(CGFloat(powf((Float(self.center.x - point.x)), 2) + powf((Float(self.center.y - point.y)), 2)))
    
    if distance < radius {
      super.touchesBegan(touches, with: event)
    }
  }
}
