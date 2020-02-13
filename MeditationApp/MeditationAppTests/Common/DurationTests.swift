//
//  DurationTests.swift
//  MeditationAppTests
//
//  Created by Mihindu de Silva on 30/1/20.
//  Copyright © 2020 Mihindu de Silva. All rights reserved.
//

import XCTest

@testable import MeditationApp

class DurationTests: XCTestCase {
  
  func testDurationWithZeroHoursZeroMinutesIsNotValid() {
    let duration = Duration(hours: 0, minutes: 0)
    let isDurationValid = duration.isValid
    XCTAssertFalse(isDurationValid)
  }
  
  func testDurationWithNonZeroMinutesIsValid() {
    let duration = Duration(hours: 0, minutes: 5)
    let isDurationValid = duration.isValid
    XCTAssertTrue(isDurationValid)
  }
  
  func testDurationWithNonZeroHoursIsValid() {
    let duration = Duration(hours: 5, minutes: 0)
    let isDurationValid = duration.isValid
    XCTAssertTrue(isDurationValid)
  }
  
  func testDurationInSecondsReturnsProperValue() {
    let duration = Duration(hours: 3, minutes: 10)
    let seconds = duration.totalSeconds
    XCTAssertEqual(seconds, 11400)
  }
  
  func testSameDurationsAreEqual() {
    let firstDuration = Duration(hours: 3, minutes: 5, seconds: 20)
    let secondDuration = Duration(hours: 3, minutes: 5, seconds: 20)
    
    let areDurationsEqual = firstDuration == secondDuration
    
    XCTAssertTrue(areDurationsEqual)
  }
  
  func testDifferentDurationsAreNotEqual() {
    let firstDuration = Duration(hours: 3, minutes: 5, seconds: 20)
    let secondDuration = Duration(hours: 7, minutes: 5, seconds: 20)
    
    let areDurationsEqual = firstDuration == secondDuration
    
    XCTAssertFalse(areDurationsEqual)
  }
  
  func testConvertSecondsToDuration() {
    let seconds = 7808 // 2 hours, 10 minutes, 8 seconds
    let secondsAsDuration = Duration(hours: 2, minutes: 10, seconds: 8)
    
    let duration = seconds.duration
    
    XCTAssertEqual(duration.hours, 2)
    XCTAssertEqual(duration.minutes, 10)
    XCTAssertEqual(duration, secondsAsDuration)
  }
  
  func testIsZeroWithDurationAllZeroesShouldBeTrue() {
    let duration = Duration(hours: 0, minutes: 0, seconds: 0)
    XCTAssertTrue(duration.isZero)
  }
  
  func testIsZeroWithDurationNotAllZeroesShouldBeFalse() {
    let hoursNonZero = Duration(hours: 1, minutes: 0, seconds: 0)
    let minutesNonZero = Duration(hours: 0, minutes: 1, seconds: 0)
    let secondsNonZero = Duration(hours: 0, minutes: 0, seconds: 1)
    let allNonZeroes = Duration(hours: 1, minutes: 1, seconds: 1)
    
    XCTAssertFalse(hoursNonZero.isZero)
    XCTAssertFalse(minutesNonZero.isZero)
    XCTAssertFalse(secondsNonZero.isZero)
    XCTAssertFalse(allNonZeroes.isZero)
  }
}
