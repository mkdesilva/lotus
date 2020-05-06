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

protocol Duration: CustomStringConvertible {
  var hours: Int { get }
  var minutes: Int { get }
  var seconds: Int { get }
  var isZero: Bool { get }
  func getSeconds() -> TimeInterval
  func tickDown(by seconds: Int)
  func tickDown(by timeInterval: TimeInterval)
  var isValid: Bool { get }
}

class SessionDuration: Codable {
  
  var time: TimeInterval
  
  init(seconds: Int) {
    time = Double(seconds)
  }
  
  init(minutes: Int, seconds: Int) {
    let minutesInSeconds = Double(minutes) * 60
    time = minutesInSeconds + Double(seconds)
  }
  
  init(hours: Int, minutes: Int) {
    let minutesInSeconds = Int.convertToSeconds(minutes: minutes)
    let hoursInSeconds = Int.convertToSeconds(hours: hours)
    time = hoursInSeconds + minutesInSeconds
  }
  
  init(hours: Int, minutes: Int, seconds: Int) {
    let minutesInSeconds = Int.convertToSeconds(minutes: minutes)
    let hoursInSeconds = Int.convertToSeconds(hours: hours)
    time = hoursInSeconds + minutesInSeconds + Double(seconds)
  }
}

extension SessionDuration: Duration {
  var isValid: Bool {
   return !isZero
  }
  
  var hours: Int {
    return Int.convertToHours(seconds: Int(time))
  }
  
  var minutes: Int {
    return Int.convertToMinutes(seconds: Int(time))
  }
  
  var seconds: Int {
    return (Int(time) % 3600) % 60
  }
  
  private var milliseconds: Int {
    return Int((time.truncatingRemainder(dividingBy: 1)) * 1000)
  }
  
  var isZero: Bool {
    return time <= 0
  }
  
  func getSeconds() -> TimeInterval {
    return time
  }
  
  /// Subtracts the time by a number of seconds.
  /// - Parameter seconds: How many seconds the time is decreased by.
  func tickDown(by seconds: Int) {
    time -= Double(seconds)
  }
  
  func tickDown(by timeInterval: TimeInterval) {
    time -= timeInterval
  }
  
  static func - (lhs: SessionDuration, rhs: SessionDuration) -> SessionDuration {
    return SessionDuration(seconds: lhs.seconds - rhs.seconds)
  }
  
  static func + (lhs: SessionDuration, rhs: SessionDuration) -> SessionDuration {
    return SessionDuration(seconds: lhs.seconds + rhs.seconds)
  }
}

extension Int {
  static func convertToSeconds(minutes: Self) -> Double {
    return Double(minutes) * 60
  }
  
  static func convertToSeconds(hours: Self) -> Double {
    return Double(hours) * 3600
  }
  
  static func convertToHours(seconds: Self) -> Int {
    return seconds / 3600
  }
  
  static func convertToMinutes(seconds: Self) -> Int {
    return (seconds % 3600) / 60
  }
}

extension SessionDuration: CustomStringConvertible {
  var description: String {
    var durationString = ""
    
    if self.hours == 0 {
      durationString = "\(self.minutes)m"
    } else if self.minutes == 0 {
      durationString = "\(self.hours)h"
    } else {
      durationString = "\(self.hours)h \(self.minutes)m"
    }
    return durationString
  }
}

extension Duration {
  var fullDescription: String {
    var durationString = ""
    
    if self.hours == 0 {
      durationString = "\(self.minutes) minutes"
    } else if self.minutes == 0 {
      durationString = "\(self.hours) hours"
    } else {
      durationString = "\(self.hours) hours \(self.minutes) minutes"
    }
    return durationString
  }
}
