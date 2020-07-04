//
//  UserDefaultsExtension.swift
//  Lotus
//
//  Created by Mihindu de Silva on 27/12/19.
//  Copyright © 2019 Mihindu de Silva. All rights reserved.
//

import Foundation

extension UserDefaults {
  func set(_ value: Any, forKey key: UserDefaultKeys) {
    set(value, forKey: key.rawValue)
  }
  
  func value(forKey key: UserDefaultKeys) -> Any? {
    return value(forKey: key.rawValue)
  }
}
