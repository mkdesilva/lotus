//
//  DefaultsManager.swift
//  Lotus
//
//  Created by Mihindu de Silva on 25/8/21.
//  Copyright © 2021 Mihindu de Silva. All rights reserved.
//

import Foundation

final class DefaultsManager {
  public var userDefaults: UserDefaults?
  public static let shared: DefaultsManager = DefaultsManager()
  
  public func inject(userDefaults: UserDefaults) {
    self.userDefaults = userDefaults
  }
  
  public var sessions: [SessionStats] {
    get {
      guard let data = userDefaults?.value(forKey: UserDefaultKeys.sessions.rawValue) as? Data,
            let decodedValue = try? PropertyListDecoder().decode([SessionStats].self, from: data)
            else { return [] }
      
      return decodedValue
      
    }
    set {
      if let encoded = try? PropertyListEncoder().encode(newValue) {
        userDefaults?.set(encoded, forKey: UserDefaultKeys.sessions.rawValue)
      }
    }
  }
}

extension DefaultsManager {
  func configure() {
    guard let defaults = UserDefaults(suiteName: "dev.mkdesilva.lotus.defaults") else { return }
    DefaultsManager.shared.inject(userDefaults: defaults)
  }
}
