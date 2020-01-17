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
    createTriangleView()
  }
  
  private func createTriangleView() {
    let triangleSizeMultiplier: CGFloat = 0.3333
    let triangleSize: CGFloat = frame.size.width * triangleSizeMultiplier
    let minX: CGFloat = 0
    let minY: CGFloat = 0
    let midY: CGFloat = triangleSize / 2
    let maxX: CGFloat = triangleSize + 5
    let maxY: CGFloat = triangleSize
    
    let triangleView = UIView()
    let path = CGMutablePath()
    
    path.move(to: CGPoint(x: minX, y: minY))
    path.addLine(to: CGPoint(x: maxX, y: midY))
    path.addLine(to: CGPoint(x: minX, y: maxY))
    path.addLine(to: CGPoint(x: minX, y: minY))
    
    let shape = CAShapeLayer()
    shape.path = path
    shape.fillColor = UIColor.white.cgColor
    triangleView.layer.insertSublayer(shape, at: 0)
    
    addSubview(triangleView)
    triangleView.frame.size = CGSize(width: maxX, height: maxY)
    triangleView.center = CGPoint(x: frame.maxX, y: frame.maxY)
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
