//
//  EndSessionView.swift
//  MeditationApp
//
//  Created by Mihindu de Silva on 5/3/20.
//  Copyright © 2020 Mihindu de Silva. All rights reserved.
//

import UIKit

final class EndSessionView: UIView {
  
  weak var delegate: EndSessionDelegate!
  
  private var closeButton: UIButton = {
    let button = RoundedRectangleButton()
    button.addTarget(self, action: #selector(tappedCloseButton), for: .touchUpInside)
    button.setTitle("CLOSE", for: .normal)
    return button
  }()
  
  func setup(delegate: EndSessionDelegate) {
    self.delegate = delegate
    addConstraintsEqualToSuperView()
    let background = BlurredBackgroundView(image: Assets.lake.image)
    addSubview(background)
    
    let statTitleLabel = UILabel()
    statTitleLabel.translatesAutoresizingMaskIntoConstraints = false
//    statTitleLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true

    statTitleLabel.text = "TIME"
    statTitleLabel.textColor = .white
    statTitleLabel.textAlignment = .center
    
    let statValueLabel = UILabel()
    statValueLabel.translatesAutoresizingMaskIntoConstraints = false
//    statTitleLabel.heightAnchor.constraint(equalToConstant: 35).isActive = true
    statValueLabel.text = "25 minutes"
    statValueLabel.textColor = .white
    statValueLabel.textAlignment = .center
    statValueLabel.font = statValueLabel.font.withSize(35)
    
    let vStack = UIStackView(arrangedSubviews: [statTitleLabel, statValueLabel, closeButton])
    vStack.axis = .vertical
    vStack.alignment = .center
    vStack.distribution = .fillProportionally
    
    addSubview(vStack)
    vStack.addConstraintsToSafeAreaSuperView(
      topSpacing: 150,
      leadingSpacing: 0,
      trailingSpacing: 0,
      bottomSpacing: -20)
//    vStack.layoutIfNeeded()
    //       stackView = vStack
  }
  
  @objc private func tappedCloseButton() {
    
  }
}
