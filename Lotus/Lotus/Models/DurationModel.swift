//
//  DurationModel.swift
//  Lotus
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
  func getTotalSeconds() -> TimeInterval
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
  
  init(timeInterval: TimeInterval) {
    time = timeInterval
  }
  
  convenience init(sessionDuration: SessionDuration) {
    self.init(timeInterval: sessionDuration.time)
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
  
  func getTotalSeconds() -> TimeInterval {
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
    let time = lhs.time - rhs.time
    return SessionDuration(timeInterval: time)
  }
  
  static func + (lhs: SessionDuration, rhs: SessionDuration) -> SessionDuration {
    let time = lhs.time + rhs.time
    return SessionDuration(timeInterval: time)
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

extension SessionDuration: Equatable {
  static func == (lhs: SessionDuration, rhs: SessionDuration) -> Bool {
    return lhs.time == rhs.time
  }
  
}

extension SessionDuration: CustomStringConvertible {
  var description: String {
    var durationString = ""
    
    durationString = "\(hours != 0 ? "\(hours)h " : "" )\(minutes != 0 ? "\(minutes)m " : "" )\(seconds != 0 ? "\(seconds)s  " : "" )"
    
    durationString = durationString.trimmingCharacters(in: .whitespaces)
    return durationString
  }
}

extension Duration {
  /// Returns a string in the format "x hours y minutes z seconds"
  var fullDescription: String {
    var durationString = ""
    
    let hourString = "\(hours != 0 ? "\(hours) hours " : "")"
    let minuteString = "\(minutes != 0 ? "\(minutes) minutes " : "")"
    let secondString = "\(seconds != 0 ? "\(seconds) seconds " : "")"
    
    durationString = "\(hourString)\(minuteString)\(secondString)"
    durationString = durationString.trimmingCharacters(in: .whitespaces)
    
    return durationString
  }
}
