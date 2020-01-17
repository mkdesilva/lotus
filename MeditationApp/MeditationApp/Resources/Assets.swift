//
//  Assets.swift
//  MeditationApp
//
//  Created by Mihindu de Silva on 6/12/19.
//  Copyright © 2019 Mihindu de Silva. All rights reserved.
//

import UIKit

struct ImageAsset {
  let named: String
}

extension ImageAsset {
  var image: UIImage! {
    guard let image = UIImage(named: named) else {
      fatalError("Could not find image: \(named)")
    }
    return image
  }
}

struct ColorAsset {
  let named: String
}

extension ColorAsset {
  var color: UIColor {
    guard let color = UIColor(named: named) else {
      fatalError("Could not find color: \(named)")
    }
    return color
  }
}

public enum Colors {
  static let slateBlue = ColorAsset(named: "slateBlue")
  static let backgroundSlateBlue = ColorAsset(named: "backgroundSlateBlue")
}

public enum Assets {
  static let lake = ImageAsset(named: "lake")
  static let xmark = ImageAsset(named: "xmark")
}
