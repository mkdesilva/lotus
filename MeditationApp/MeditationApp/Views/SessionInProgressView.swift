//
//  SessionInProgressView.swift
//  MeditationApp
//
//  Created by Mihindu de Silva on 17/1/20.
//  Copyright © 2020 Mihindu de Silva. All rights reserved.
//

import UIKit

final class SessionInProgressView: UIView {
  
  var circleProgressView: CircleProgressView = {
    let view = CircleProgressView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.setup()
    return view
  }()
  
  func setup() {
    addConstraintsEqualToSuperView()
    
    let blurredBackgroundView = BlurredBackgroundView(image: Assets.lake.image)
    addSubview(blurredBackgroundView)
    
    let vStack = UIStackView(arrangedSubviews: [circleProgressView])
    vStack.addConstraintsEqualToSuperView()
    
    vStack.axis = .vertical
    vStack.alignment = .center
    addSubview(vStack)
  }
  
}
