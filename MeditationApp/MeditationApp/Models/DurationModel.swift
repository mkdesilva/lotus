//
//  DurationModel.swift
//  MeditationApp
//
//  Created by Mihindu de Silva on 17/1/20.
//  Copyright © 2020 Mihindu de Silva. All rights reserved.
//

struct Duration: Codable {
  let hours: Int
  let minutes: Int
}

extension Duration: Equatable {}

extension Duration: Validation {
  var isValid: Bool {
    if hours == 0 && minutes == 0 {
      return false
    }
    
    return true
  }
}

protocol Validation {
  var isValid: Bool { get }
}
