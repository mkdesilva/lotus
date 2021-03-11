//
//  UIImageExtension.swift
//  Lotus
//
//  Created by Mihindu de Silva on 6/2/21.
//  Copyright © 2021 Mihindu de Silva. All rights reserved.
//

import UIKit

extension UIImage {
  class func circle(diameter: CGFloat, fillColor: UIColor, strokeColor: UIColor?) -> UIImage {
    UIGraphicsBeginImageContextWithOptions(CGSize(width: diameter, height: diameter), false, 0)
    let ctx = UIGraphicsGetCurrentContext()!
    ctx.saveGState()
    
    let rect = CGRect(x: 0, y: 0, width: diameter, height: diameter)
    ctx.setFillColor(fillColor.cgColor)
    ctx.fillEllipse(in: rect)
    
    if let strokeColor = strokeColor {
      ctx.setStrokeColor(strokeColor.cgColor)
      ctx.strokeEllipse(in: rect)
    }
    
    ctx.restoreGState()
    let img = UIGraphicsGetImageFromCurrentImageContext()!
    UIGraphicsEndImageContext()
    
    return img
  }
}
