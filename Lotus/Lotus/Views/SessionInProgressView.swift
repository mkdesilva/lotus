//
//  SessionInProgressView.swift
//  Lotus
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
    let button = RoundedRectangleButton()
    button.setTitle("END", for: .normal)
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
  
  var pauseView: UIView?
  
func setup(delegate: SessionInProgressViewController) {
    self.delegate = delegate
    addConstraintsEqualToSuperView()
    let blurredBackgroundView = BlurredBackgroundView(image: Assets.lake.image)
    addSubview(blurredBackgroundView)
    
    let circleContainerView = UIView()
    circleContainerView.translatesAutoresizingMaskIntoConstraints = false
    circleContainerView.widthAnchor.constraint(equalToConstant: 200).isActive = true
    circleContainerView.heightAnchor.constraint(equalToConstant: 200).isActive = true
    circleContainerView.addSubview(circleProgressView)
    
    pauseView = setupPauseView(circleContainerView)
    
    setupVerticalStackView(circleContainerView)
    
    circleProgressView.setup(centerIn: circleContainerView)
  }
  
  var stackView: UIStackView?
  
  private func setupVerticalStackView(_ circleContainerView: UIView) {
    let vStack = UIStackView(arrangedSubviews: [timeLabel, circleContainerView, endButton])
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
    stackView = vStack
  }
  
  private func setupPauseView(_ containerView: UIView) -> UIView {
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
    
    return pauseView
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
  
  private func resumeCircleAnimation() {
    circleProgressView.resumeAnimation()
  }
  
  private func pauseCircleAnimation() {
    circleProgressView.pauseAnimation()
    
  }
  
  func showPausedView() {
    pauseCircleAnimation()
    guard let pauseView = pauseView else { return }
    guard let containerView = pauseView.superview else { return }
    pauseView.removeFromSuperview()
    
    let triangleView = TriangleView(frame: containerView.frame)
    containerView.addSubview(triangleView)
  
    triangleView.translatesAutoresizingMaskIntoConstraints = false
    triangleView.widthAnchor.constraint(equalTo: containerView.widthAnchor).isActive = true
    triangleView.heightAnchor.constraint(equalTo: containerView.heightAnchor).isActive = true
    triangleView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor, constant: containerView.bounds.width / 3).isActive = true
    triangleView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor, constant: containerView.bounds.height / 3).isActive = true
    
    let tapGestureRecogniser = UITapGestureRecognizer(target: self, action: #selector(tappedPauseButton))
    triangleView.addGestureRecognizer(tapGestureRecogniser)
    self.pauseView = triangleView
  }
  
  func showInProgressView() {
    resumeCircleAnimation()
    guard let pauseView = pauseView else { return }
    guard let containerView = pauseView.superview else { return }
    pauseView.removeFromSuperview()
    self.pauseView = setupPauseView(containerView)
  }
  
  public func endSession(completion: (() -> Void)? = nil ) {
    UIView.animate(withDuration: 0.75, animations: {
      self.stackView?.alpha = 0
    }, completion: { _ in
      completion?()
    })
  }
}
