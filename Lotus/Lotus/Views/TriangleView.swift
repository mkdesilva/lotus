//
//  TriangleView.swift
//  Lotus
//
//  Created by Mihindu de Silva on 14/2/20.
//  Copyright © 2020 Mihindu de Silva. All rights reserved.
//

import UIKit

final class TriangleView: UIView {
  override init(frame: CGRect) {
    super.init(frame: frame)
    let triangleSizeMultiplier: CGFloat = 0.3333
    let triangleSize: CGFloat = frame.size.width * triangleSizeMultiplier
    let minX: CGFloat = 0
    let minY: CGFloat = 0
    let midY: CGFloat = triangleSize / 2
    let maxX: CGFloat = triangleSize + 5
    let maxY: CGFloat = triangleSize
    
    let path = CGMutablePath()
    
    path.move(to: CGPoint(x: minX, y: minY))
    path.addLine(to: CGPoint(x: maxX, y: midY))
    path.addLine(to: CGPoint(x: minX, y: maxY))
    path.addLine(to: CGPoint(x: minX, y: minY))
    
    let shape = CAShapeLayer()
    shape.path = path
    shape.fillColor = UIColor.white.cgColor
    layer.insertSublayer(shape, at: 0)
    
    self.frame.size = CGSize(width: maxX, height: maxY)
    center = CGPoint(x: frame.maxX, y: frame.maxY)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
