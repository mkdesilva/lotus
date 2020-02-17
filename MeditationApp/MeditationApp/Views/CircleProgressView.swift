//
//  CircleProgressView.swift
//  MeditationApp
//
//  Created by Mihindu de Silva on 17/1/20.
//  Copyright © 2020 Mihindu de Silva. All rights reserved.
//

import UIKit

class CircleProgressView: UIView {
  
  var shapeLayer: CAShapeLayer!
  
  func setup(centerIn centerView: UIView) {
    drawShape(centerView: centerView)
  }

  private func drawShape(centerView: UIView) {
    
    let center = CGPoint(x: centerView.bounds.midX, y: centerView.bounds.midY)
    
    let circlePath = UIBezierPath(
      arcCenter: center,
      radius: 100,
      startAngle: -CGFloat.pi / 2,
      endAngle: CGFloat.pi * 3/2,
      clockwise: true)
    
    let backgroundLayer = CAShapeLayer()
    backgroundLayer.path = circlePath.cgPath
    backgroundLayer.fillColor = nil
    backgroundLayer.strokeColor = Colors.backgroundSlateBlue.color.cgColor
    backgroundLayer.lineWidth = 10
    
    layer.addSublayer(backgroundLayer)
    
    shapeLayer = CAShapeLayer()
    shapeLayer.path = circlePath.cgPath
    shapeLayer.fillColor = nil
    shapeLayer.strokeColor = Colors.slateBlue.color.cgColor
    shapeLayer.lineWidth = 10
    shapeLayer.lineCap = .round
    shapeLayer.strokeEnd = 0
    
    layer.addSublayer(shapeLayer)
  }
  
  var progressAnimation: CABasicAnimation?
  
  func animate(durationInSeconds: Int) {
    let animationKeyPath = "strokeEnd"

    let animation = CABasicAnimation(keyPath: animationKeyPath)
    animation.toValue = 1
    animation.duration = Double(durationInSeconds)
    animation.fillMode = .forwards
    animation.isRemovedOnCompletion = false
    shapeLayer.add(animation, forKey: animationKeyPath)
    progressAnimation = animation
  }
  
  func pauseAnimation() {
    let pausedTime = shapeLayer.convertTime(CACurrentMediaTime(), from: nil)
    shapeLayer.speed = 0
    shapeLayer.timeOffset = pausedTime
  }
  
  func resumeAnimation() {
    let pausedTime = shapeLayer.timeOffset
    shapeLayer.speed = 1
    shapeLayer.beginTime = 0
    
    let timeSincePause = shapeLayer.convertTime(CACurrentMediaTime(), from: nil) - pausedTime
    shapeLayer.beginTime = timeSincePause
  }
}
