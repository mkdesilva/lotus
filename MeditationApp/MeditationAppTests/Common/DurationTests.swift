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
    let duration = SessionDuration(hours: 0, minutes: 0)
    let isDurationValid = duration.isValid
    XCTAssertFalse(isDurationValid)
  }
  
  func testDurationWithNonZeroMinutesIsValid() {
    let duration = SessionDuration(hours: 0, minutes: 5)
    let isDurationValid = duration.isValid
    XCTAssertTrue(isDurationValid)
  }
  
  func testDurationWithNonZeroHoursIsValid() {
    let duration = SessionDuration(hours: 5, minutes: 0)
    let isDurationValid = duration.isValid
    XCTAssertTrue(isDurationValid)
  }
  
  func testDurationInSecondsReturnsProperValue() {
    let duration = SessionDuration(hours: 3, minutes: 10)
    let seconds = duration.getTotalSeconds()
    XCTAssertEqual(seconds, 11400)
  }
  
  func testSameDurationsAreEqual() {
    let firstDuration = SessionDuration(hours: 3, minutes: 5, seconds: 20)
    let secondDuration = SessionDuration(hours: 3, minutes: 5, seconds: 20)
    
    let areDurationsEqual = firstDuration == secondDuration
    
    XCTAssertTrue(areDurationsEqual)
  }
  
  func testDifferentDurationsAreNotEqual() {
    let firstDuration = SessionDuration(hours: 3, minutes: 5, seconds: 20)
    let secondDuration = SessionDuration(hours: 7, minutes: 5, seconds: 20)
    
    let areDurationsEqual = firstDuration == secondDuration
    
    XCTAssertFalse(areDurationsEqual)
  }
  
  func testConvertSecondsToDuration() {
    let seconds = 7808 // 2 hours, 10 minutes, 8 seconds
    let secondsAsDuration = SessionDuration(hours: 2, minutes: 10, seconds: 8)
    
    let duration = SessionDuration(seconds: seconds)
    
    XCTAssertEqual(duration.hours, 2)
    XCTAssertEqual(duration.minutes, 10)
    XCTAssertEqual(duration, secondsAsDuration)
  }
  
  func testIsZeroWithDurationAllZeroesShouldBeTrue() {
    let duration = SessionDuration(hours: 0, minutes: 0, seconds: 0)
    XCTAssertTrue(duration.isZero)
  }
  
  func testIsZeroWithDurationNotAllZeroesShouldBeFalse() {
    let hoursNonZero = SessionDuration(hours: 1, minutes: 0, seconds: 0)
    let minutesNonZero = SessionDuration(hours: 0, minutes: 1, seconds: 0)
    let secondsNonZero = SessionDuration(hours: 0, minutes: 0, seconds: 1)
    let allNonZeroes = SessionDuration(hours: 1, minutes: 1, seconds: 1)
    
    XCTAssertFalse(hoursNonZero.isZero)
    XCTAssertFalse(minutesNonZero.isZero)
    XCTAssertFalse(secondsNonZero.isZero)
    XCTAssertFalse(allNonZeroes.isZero)
  }
  
  func testDurationDescription() {
    let duration = SessionDuration(hours: 4, minutes: 12, seconds: 39)
    
    let durationDescription: String = duration.description
    
    XCTAssertEqual(durationDescription, "4h 12m 39s")
  }
  
  func testDurationFullDescription() {
    let duration = SessionDuration(hours: 4, minutes: 12, seconds: 39)
    
    let durationDescription: String = duration.fullDescription
    
    XCTAssertEqual(durationDescription, "4 hours 12 minutes 39 seconds")
  }
  
  func testDurationTickDown() {
    let duration = SessionDuration(hours: 3, minutes: 0, seconds: 0)
    
    duration.tickDown(by: 3)
    
    XCTAssertEqual(duration, SessionDuration(hours: 2, minutes: 59, seconds: 57))
  }
  
  func testCreateDurationWithSessionDuration() {
    let initialDuration = SessionDuration(hours: 4, minutes: 2, seconds: 1)
    
    let newDuration = SessionDuration(sessionDuration: initialDuration)
    
    XCTAssertEqual(initialDuration, newDuration)
  }
}
