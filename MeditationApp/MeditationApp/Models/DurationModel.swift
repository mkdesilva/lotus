//
//  DurationModel.swift
//  MeditationApp
//
//  Created by Mihindu de Silva on 17/1/20.
//  Copyright © 2020 Mihindu de Silva. All rights reserved.
//

import Foundation

protocol Validation {
  var isValid: Bool { get }
}

final class Duration: Codable {
  var hours: Int
  var minutes: Int
  var seconds: Int
  
  init(hours: Int, minutes: Int) {
    self.hours = hours
    self.minutes = minutes
    self.seconds = 0
  }
  
  init(hours: Int, minutes: Int, seconds: Int) {
    self.hours = hours
    self.minutes = minutes
    self.seconds = seconds
  }
}

extension Duration {
  
  var isZero: Bool {
    return hours == 0 && minutes == 0 && seconds == 0
  }
  
  var totalSeconds: Int {
    return (hours * 60 * 60) + (minutes * 60) + (seconds)
  }
  
  func tickDown(bySeconds: Int) {
    var durationInSeconds = self.totalSeconds
    durationInSeconds -= bySeconds
    let newDuration = durationInSeconds.duration
    
    hours = newDuration.hours
    minutes = newDuration.minutes
    seconds = newDuration.seconds
  }
}

extension Duration: Equatable {
  static func == (lhs: Duration, rhs: Duration) -> Bool {
    return lhs.hours == rhs.hours && lhs.minutes == rhs.minutes && lhs.seconds == rhs.seconds
  }
}

extension Duration: CustomStringConvertible {
  var description: String {
    return "\(hours)h:\(minutes)m:\(seconds)s"
  }
}

extension Duration: Validation {
  var isValid: Bool {
    if hours == 0 && minutes == 0 {
      return false
    }
    
    return true
  }
}

extension Int {
  var duration: Duration {
    let hours = self / 3600
    let minutes = (self % 3600) / 60
    let seconds = (self % 3600) % 60
    return Duration(hours: hours, minutes: minutes, seconds: seconds)
  }
}
