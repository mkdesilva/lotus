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
      return userDefaults?.array(forKey: UserDefaultKeys.sessions.rawValue) as? [SessionStats] ?? []
    }
    set {
      userDefaults?.set(newValue, forKey: UserDefaultKeys.sessions.rawValue)
    }
  }
}

extension DefaultsManager {
  func configure() {
    guard let defaults = UserDefaults(suiteName: "dev.mkdesilva.lotus") else { return }
    DefaultsManager.shared.inject(userDefaults: defaults)
  }
}
