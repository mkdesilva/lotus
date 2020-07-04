//
//  EndSessionView.swift
//  Lotus
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
  
  private var statValueLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = "25 minutes"
    label.textColor = .white
    label.textAlignment = .center
    label.font = UIFont.systemFont(ofSize: 35)
    return label
  }()
  
  func setup(delegate: EndSessionDelegate) {
    self.delegate = delegate
    addConstraintsEqualToSuperView()
    let background = BlurredBackgroundView(image: Assets.lake.image)
    addSubview(background)
    
    let statTitleLabel = UILabel()
    statTitleLabel.translatesAutoresizingMaskIntoConstraints = false
    statTitleLabel.text = "TIME"
    statTitleLabel.textColor = .white
    statTitleLabel.textAlignment = .center
    
    let vStack = UIStackView(arrangedSubviews: [statTitleLabel, statValueLabel])
    vStack.axis = .vertical
    vStack.alignment = .center
    vStack.distribution = .equalCentering
    vStack.spacing = 16
    addSubview(vStack)
    addSubview(closeButton)
    vStack.centerInSuperView()
    closeButton.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -100).isActive = true
    closeButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
  }
  
  @objc private func tappedCloseButton() {
    delegate.closeView()
  }
  
  func displayStats(durationText: String) {
    statValueLabel.text = durationText
  }
}
