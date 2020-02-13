//
//  SessionInProgressView.swift
//  MeditationApp
//
//  Created by Mihindu de Silva on 17/1/20.
//  Copyright © 2020 Mihindu de Silva. All rights reserved.
//

import UIKit

final class SessionInProgressView: UIView {
  
  private var circleProgressView: CircleProgressView = {
    let view = CircleProgressView()
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  private var endButton: UIButton = {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.heightAnchor.constraint(equalToConstant: 50).isActive = true
    button.widthAnchor.constraint(equalToConstant: 150).isActive = true
    button.layer.cornerRadius = 15
    button.setTitle("END", for: .normal)
    button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
    
    button.backgroundColor = Colors.slateBlue.color
    button.addTarget(self, action: #selector(tappedEndButton), for: .touchUpInside)
    
    return button
  }()
  
  private var timeLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textColor =  .white
    label.font = label.font.withSize(55)
    label.textAlignment = .center
    return label
  }()
  
  weak var delegate: SessionInProgressViewController!
  
  func setup(delegate: SessionInProgressViewController) {
    self.delegate = delegate
    addConstraintsEqualToSuperView()
    let blurredBackgroundView = BlurredBackgroundView(image: Assets.lake.image)
    addSubview(blurredBackgroundView)
    
    let containerView = UIView()
    containerView.translatesAutoresizingMaskIntoConstraints = false
    containerView.widthAnchor.constraint(equalToConstant: 200).isActive = true
    containerView.heightAnchor.constraint(equalToConstant: 200).isActive = true
    containerView.addSubview(circleProgressView)
    
    setupPauseView(containerView)
    
    setupVerticalStackView(containerView)
    
    circleProgressView.setup(centerIn: containerView)
  }
  
  private func setupVerticalStackView(_ containerView: UIView) {
    let vStack = UIStackView(arrangedSubviews: [timeLabel, containerView, endButton])
    vStack.axis = .vertical
    vStack.alignment = .center
    vStack.distribution = .equalCentering
    
    addSubview(vStack)
    vStack.addConstraintsToSafeAreaSuperView(
      topSpacing: 150,
      leadingSpacing: 0,
      trailingSpacing: 0,
      bottomSpacing: -150)
    vStack.layoutIfNeeded()
  }
  
  private func setupPauseView(_ containerView: UIView) {
    let pauseView = UIButton(type: .custom)
    containerView.addSubview(pauseView)
    pauseView.addTarget(self, action: #selector(tappedPauseButton), for: .touchUpInside)
    
    pauseView.translatesAutoresizingMaskIntoConstraints = false
    pauseView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
    pauseView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
    pauseView.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.3).isActive = true
    pauseView.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 0.7).isActive = true
    let bars = [UIView(), UIView()]
    
    let pauseStackView = UIStackView(arrangedSubviews: bars)
    pauseView.addSubview(pauseStackView)
    pauseStackView.addConstraintsEqualToSuperView()
    pauseStackView.axis = .horizontal
    pauseStackView.distribution = .equalCentering
    pauseStackView.isUserInteractionEnabled = false
    
    for bar in bars {
      bar.isUserInteractionEnabled = false
      bar.translatesAutoresizingMaskIntoConstraints = false
      bar.backgroundColor = .white
      bar.layer.cornerRadius = 10
      bar.widthAnchor.constraint(equalTo: pauseView.widthAnchor, multiplier: 0.35).isActive = true
    }
  }
}

extension SessionInProgressView {
  
  @objc func tappedPauseButton() {
    delegate.tappedPauseButton()
  }
  
  @objc func tappedEndButton() {
    delegate.tappedEndButton()
  }
  
  func setTimeText(_ text: String) {
    timeLabel.text = text
  }
  
  func startAnimatingProgressCircle(durationInSeconds: Int) {
    circleProgressView.animate(durationInSeconds: durationInSeconds)
  }
  
  func resumeCircleAnimation() {
    // TODO: Implement this
    
  }
  
  func pauseCircleAnimation() {
    // TODO: Implement this
    
  }
}

extension UIStackView {
  func addBackground(color: UIColor) {
    let subView = UIView(frame: bounds)
    subView.backgroundColor = color
    subView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    insertSubview(subView, at: 0)
  }
}
