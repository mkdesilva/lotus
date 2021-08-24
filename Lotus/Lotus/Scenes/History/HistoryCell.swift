//
//  HistoryCell.swift
//  Lotus
//
//  Created by Mihindu de Silva on 24/8/21.
//  Copyright © 2021 Mihindu de Silva. All rights reserved.
//

import UIKit

final class HistoryCell: UITableViewCell {
  var session: HistoryViewController.Session? {
    didSet {
      timeLabel.text = session?.date
      durationLabel.text = session?.duration
    }
  }
  
  private let timeLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textColor = .white
    label.textAlignment = .left
    return label
  }()
  
  private let durationLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textColor = .white
    label.textAlignment = .center
    return label
  }()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.3)
    addSubview(timeLabel)
    addSubview(durationLabel)
    
    timeLabel.addConstraints(
      topSpacing: 16,
      leadingSpacing: 16,
      trailingSpacing: 0
    )
    
    let badgeView = UIView()
    addSubview(badgeView)
    badgeView.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 8).isActive = true
    badgeView.addConstraints(leadingSpacing: 16, bottomSpacing: -16)
    badgeView.layer.cornerRadius = 15
    badgeView.backgroundColor = Colors.slateBlue.color
    
    badgeView.addSubview(durationLabel)
    durationLabel.addConstraints(topSpacing: 8, leadingSpacing: 16, trailingSpacing: -16, bottomSpacing: -8)
    
    let separator = UIView()
    addSubview(separator)
    separator.backgroundColor = UIColor(
      red: 0,
      green: 0,
      blue: 0,
      alpha: 0.2
    )
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }
}
