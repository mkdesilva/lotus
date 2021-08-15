//
//  BlurredBackgroundView.swift
//  Lotus
//
//  Created by Mihindu de Silva on 7/12/19.
//  Copyright © 2019 Mihindu de Silva. All rights reserved.
//

import UIKit

final class BlurredBackgroundView: UIImageView {
  
  var visualEffectView: UIVisualEffectView?
  
  override init(image: UIImage?) {
    super.init(image: image)
    setup()
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setup()
  }
  
  func setup() {
    backgroundColor = .clear
    contentMode = .center
    
    if let superviewFrame = superview?.frame {
      frame = superviewFrame
    }
    
    blurView()
  }
  
  private func getVisualEffectView() -> UIVisualEffectView {
    let blur: UIBlurEffect
    
    if #available(iOS 13.0, *) {
      switch UITraitCollection.current.userInterfaceStyle {
      case .dark:
        blur = UIBlurEffect(style: .dark)
      case .light, .unspecified:
        blur = UIBlurEffect(style: .light)
      @unknown default:
        blur = UIBlurEffect(style: .light)
      }
    } else {
      // Fallback on earlier versions
      blur = UIBlurEffect(style: .light)
    }
    
    return UIVisualEffectView(effect: blur)
  }
  
  private func blurView() {
    visualEffectView?.removeFromSuperview()
    
    visualEffectView = getVisualEffectView()
    guard let vfxView = visualEffectView else {
      fatalError("Something went wrong with getVisualEffectView")
      
    }
    vfxView.frame = self.frame
    vfxView.translatesAutoresizingMaskIntoConstraints = false
    insertSubview(vfxView, at: 0)
  }
  
  override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
    blurView()
  }
}
