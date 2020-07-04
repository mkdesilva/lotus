//
//  UIViewExtension.swift
//  Lotus
//
//  Created by Mihindu de Silva on 7/12/19.
//  Copyright © 2019 Mihindu de Silva. All rights reserved.
//

import UIKit

extension UIView {
  func addConstraintsEqualToSuperView() {
    guard let superview = superview else { return }
    translatesAutoresizingMaskIntoConstraints = false
    topAnchor.constraint(equalTo: superview.topAnchor).isActive = true
    bottomAnchor.constraint(equalTo: superview.bottomAnchor).isActive = true
    leadingAnchor.constraint(equalTo: superview.leadingAnchor).isActive = true
    trailingAnchor.constraint(equalTo: superview.trailingAnchor).isActive = true
  }
  
  func addConstraints(
    topSpacing: CGFloat? = nil,
    leadingSpacing: CGFloat? = nil,
    trailingSpacing: CGFloat? = nil,
    bottomSpacing: CGFloat? = nil) {
    guard let superview = superview else { return }
    translatesAutoresizingMaskIntoConstraints = false
    
    if let topSpacing = topSpacing {
      topAnchor.constraint(equalTo: superview.topAnchor, constant: topSpacing).isActive = true
    }
    
    if let leadingSpacing = leadingSpacing {
      leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: leadingSpacing).isActive = true
    }
    if let trailingSpacing = trailingSpacing {
      trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: trailingSpacing).isActive = true
    }
    
    if let bottomSpacing = bottomSpacing {
      bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: bottomSpacing).isActive = true
    }
  }
  
  func centerInSuperView() {
    guard let superview = superview else { return }
    translatesAutoresizingMaskIntoConstraints = false
    centerXAnchor.constraint(equalTo: superview.centerXAnchor).isActive = true
    centerYAnchor.constraint(equalTo: superview.centerYAnchor).isActive = true
  }
  
  func addConstraintsEqualToSafeAreaSuperView() {
    guard let superview = superview else { return }
    translatesAutoresizingMaskIntoConstraints = false
    topAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.topAnchor).isActive = true
    bottomAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.bottomAnchor).isActive = true
    leadingAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.leadingAnchor).isActive = true
    trailingAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.trailingAnchor).isActive = true
  }
  
  func addConstraintsToSafeAreaSuperView(
     topSpacing: CGFloat? = nil,
     leadingSpacing: CGFloat? = nil,
     trailingSpacing: CGFloat? = nil,
     bottomSpacing: CGFloat? = nil) {
     guard let superview = superview else { return }
     translatesAutoresizingMaskIntoConstraints = false
     
     if let topSpacing = topSpacing {
       topAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.topAnchor, constant: topSpacing).isActive = true
     }
     
     if let leadingSpacing = leadingSpacing {
       leadingAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.leadingAnchor, constant: leadingSpacing).isActive = true
     }
     if let trailingSpacing = trailingSpacing {
       trailingAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.trailingAnchor, constant: trailingSpacing).isActive = true
     }
     
     if let bottomSpacing = bottomSpacing {
       bottomAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.bottomAnchor, constant: bottomSpacing).isActive = true
     }
   }
  
  func constraintHeight(equalToConstant: CGFloat) {
    translatesAutoresizingMaskIntoConstraints = false
    heightAnchor.constraint(equalToConstant: equalToConstant).isActive = true
  }
}
