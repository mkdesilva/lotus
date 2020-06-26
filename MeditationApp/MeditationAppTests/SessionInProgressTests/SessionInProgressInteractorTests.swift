//
//  SessionInProgressInteractorTests.swift
//  MeditationAppTests
//
//  Created by Mihindu de Silva on 26/6/20.
//  Copyright © 2020 Mihindu de Silva. All rights reserved.
//

import XCTest

@testable import MeditationApp

class SessionInProgressInteractorTests: XCTestCase {
  
  // MARK: - Subject under test
  
  var sut: SessionInProgressInteractor!
  var presenterSpy: SessionInProgressPresenterSpy!
  let initialDuration = SessionDuration(hours: 5, minutes: 2)
  
  // MARK: - Test lifecycle
  
  override func setUp() {
    super.setUp()
    setupSessionInProgressInteractor()
  }
  
  override func tearDown() {
    if (sut.sessionTimer != nil) {
      sut.sessionTimer.invalidate()
    }
    sut = nil
    presenterSpy = nil
    super.tearDown()
  }
  
  // MARK: - Test setup
  
  private func setupSessionInProgressInteractor() {
    sut = SessionInProgressInteractor()
    sut.session = Session(initialDuration: initialDuration)
    presenterSpy = SessionInProgressPresenterSpy()
    sut.presenter = presenterSpy
  }
  
  // MARK: - Test doubles
  
  final class SessionInProgressPresenterSpy: SessionInProgressPresenterInterface {
    var presentDurationCalled = false
    var presentDurationResponse: SessionInProgress.UpdateDuration.Response!
    func presentDuration(response: SessionInProgress.UpdateDuration.Response) {
      presentDurationCalled = true
      presentDurationResponse = response
    }
    
    
    var presentPausedCalled = false
    var presentPausedResponse: SessionInProgress.TogglePause.Response!
    func presentPaused(response: SessionInProgress.TogglePause.Response) {
      presentPausedCalled = true
      presentPausedResponse = response
    }
    
    var presentEndSessionCalled = false
    
    func presentEndSession(response: SessionInProgress.EndSession.Response) {
      presentEndSessionCalled = true
    }
  }
  
  // MARK: Tests
  
  func testGetInitialDuration() {
    // Given
    let request = SessionInProgress.GetInitialDuration.Request()
    
    // When
    sut.getInitialDuration(request: request)
    
    // Then
    XCTAssert(presenterSpy.presentDurationCalled)
    XCTAssertEqual(presenterSpy.presentDurationResponse.duration, initialDuration)
  }
  
  func testUpdateDuration() {
    let request = SessionInProgress.UpdateDuration.Request(timeInterval: 60)
    let expectedDuration = SessionDuration(hours: 5, minutes: 1)
    sut.updateDuration(request: request)
    
    XCTAssert(presenterSpy.presentDurationCalled)
    XCTAssertEqual(presenterSpy.presentDurationResponse.duration, expectedDuration)
  }
  
  func testStartSession() {
    let request = SessionInProgress.StartSession.Request()
    
    sut.startSession(request: request)
    
    XCTAssert(sut.session.isInProgress)
    XCTAssertNotNil(sut.sessionTimer)
    XCTAssert(sut.sessionTimer.isValid)
  }
  
  func testTogglePauseWhenSessionInProgress() {
    let request = SessionInProgress.TogglePause.Request()
    sut.session.isInProgress = true;
    
    let timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) {_ in
      return
    }
    
    sut.sessionTimer = timer
    
    sut.togglePause(request: request)
    
    XCTAssertFalse(sut.session.isInProgress)
    XCTAssert(presenterSpy.presentPausedCalled)
    XCTAssert(presenterSpy.presentPausedResponse.isPaused)
  }
  
  func testTogglePauseWhenSessionIsPaused() {
    let request = SessionInProgress.TogglePause.Request()
    sut.session.isInProgress = false;
    
    sut.togglePause(request: request)
    
    XCTAssert(sut.session.isInProgress)
    XCTAssertNotNil(sut.sessionTimer)
    XCTAssert(sut.sessionTimer.isValid)
    XCTAssert(presenterSpy.presentPausedCalled)
    XCTAssertFalse(presenterSpy.presentPausedResponse.isPaused)
    XCTAssert(presenterSpy.presentDurationCalled)
  }
  
  func testEndSessionWithValidTimer() {
    let request = SessionInProgress.EndSession.Request()
    sut.endSession(request: request)
    XCTAssert(presenterSpy.presentEndSessionCalled)
  }
}
