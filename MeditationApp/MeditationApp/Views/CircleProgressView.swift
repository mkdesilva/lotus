//
//  CircleProgressView.swift
//  MeditationApp
//
//  Created by Mihindu de Silva on 17/1/20.
//  Copyright © 2020 Mihindu de Silva. All rights reserved.
//

import UIKit

class CircleProgressView: UIView {
  
  func setup() {
    let circlePath = UIBezierPath(arcCenter: center, radius: 100, startAngle: -CGFloat.pi / 2, endAngle: 2 * CGFloat.pi, clockwise: true)
    
    let backgroundLayer = CAShapeLayer()
    backgroundLayer.path = circlePath.cgPath
    backgroundLayer.fillColor = nil
    backgroundLayer.strokeColor = Colors.backgroundSlateBlue.color.cgColor
    backgroundLayer.lineWidth = 10
    
    layer.addSublayer(backgroundLayer)
    
    let shapeLayer = CAShapeLayer()
    shapeLayer.path = circlePath.cgPath
    shapeLayer.fillColor = nil
    shapeLayer.strokeColor = Colors.slateBlue.color.cgColor
    shapeLayer.lineWidth = 10
    shapeLayer.lineCap = .round
    shapeLayer.strokeEnd = 0.25
    
    layer.addSublayer(shapeLayer)
  }
}
