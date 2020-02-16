//
//  BeginButton.swift
//  MeditationApp
//
//  Created by Mihindu de Silva on 18/12/19.
//  Copyright © 2019 Mihindu de Silva. All rights reserved.
//

import UIKit

class BeginButton: UIButton, CustomView {
  
  var createSessionView: CreateSessionView?
  
  func setup() {
    let size: CGFloat = 200
    translatesAutoresizingMaskIntoConstraints = false
    backgroundColor = Colors.slateBlue.color
    widthAnchor.constraint(equalToConstant: size).isActive = true
    heightAnchor.constraint(equalToConstant: size).isActive = true
    layer.cornerRadius = size / 2
    clipsToBounds = true
    addTarget(self, action: #selector(tappedBegin), for: .touchUpInside)
    layoutIfNeeded()
    let triangleView = TriangleView(frame: frame)
    triangleView.isUserInteractionEnabled = false
    addSubview(triangleView)
    triangleView.layoutIfNeeded()
  }
  
  @objc func tappedBegin() {
    guard let delegate = createSessionView else { return }
    delegate.tappedBegin()
  }
}

extension BeginButton {
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    let radius = frame.width / 2
    print("touches began")
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
