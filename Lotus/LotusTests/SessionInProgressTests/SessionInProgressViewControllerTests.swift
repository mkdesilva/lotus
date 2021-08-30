//
//  SessionInProgressViewControllerTests.swift
//  LotusTests
//
//  Created by Mihindu de Silva on 15/8/21.
//  Copyright © 2021 Mihindu de Silva. All rights reserved.
//

import XCTest

@testable import Lotus

class SessionInProgressViewControllerTests: XCTestCase {
  
  // MARK: - Subject under test
  
  var sut: SessionInProgressViewController!
  var interactorSpy: SessionInProgressInteractorSpy!
  var routerSpy: SessionInProgressRouterSpy!
  var audioControllerSpy: AudioControllerSpy!
  
  // MARK: - Test lifecycle
  
  override func setUp() {
    super.setUp()
    setupSessionInProgressViewController()
  }
  
  override func tearDown() {
    interactorSpy = nil
    routerSpy = nil
    sut = nil
    audioControllerSpy = nil
    super.tearDown()
  }
  
  // MARK: - Test setup
  
  private func setupSessionInProgressViewController() {
    sut = SessionInProgressViewController()
    interactorSpy = SessionInProgressInteractorSpy()
    sut.interactor = interactorSpy
    routerSpy = SessionInProgressRouterSpy()
    sut.router = routerSpy
    audioControllerSpy = AudioControllerSpy()
    sut.audioController = audioControllerSpy
  }
  
  // MARK: - Test doubles
  
  final class SessionInProgressInteractorSpy: SessionInProgressInteractorInterface {
    var session: Session! = Session(initialDuration: SessionDuration(seconds: 5))
    
    var getInitialDurationCalled = false
    func getInitialDuration(request: SessionInProgress.GetInitialDuration.Request) {
      getInitialDurationCalled = true
    }
    
    var startSessionCalled = false
    func startSession(request: SessionInProgress.StartSession.Request) {
      startSessionCalled = true
    }
    
    var updateDurationCalled = false
    func updateDuration(request: SessionInProgress.UpdateDuration.Request) {
      updateDurationCalled = true
    }
    
    var togglePauseCalled = false
    func togglePause(request: SessionInProgress.TogglePause.Request) {
      togglePauseCalled = true
    }
    
    var endSessionCalled = false
    func endSession(request: SessionInProgress.EndSession.Request) {
      endSessionCalled = true
    }
  }
  
  final class SessionInProgressRouterSpy: SessionInProgressRouterInterface {
    
    var navigateToEndSessionCalled = false
    func navigateToEndSession(sessionStats: SessionStats) {
      navigateToEndSessionCalled = true
    }
  }
  
  final class AudioControllerSpy: AudioControllerInterface {
    var playAudioCalled = false
    func playAudio(fileName: String, fileExtension: String) {
      playAudioCalled = true
    }
    
    var disableAudioSessionCalled = false
    func disableAudioSession() {
      disableAudioSessionCalled = true
    }
    
    var getFileDurationCalled = false
    func getFileDuration(fileName: String, fileExtension: String) -> Double {
      getFileDurationCalled = true
      return 2
    }
  }
  
  // MARK: Tests
  
  func testGetInitialDurationShouldBeCalledAtStart() {
    sut.viewDidLoad()
    
    XCTAssertTrue(interactorSpy.getInitialDurationCalled)
  }
  
  func testStartSessionShouldBeCalledAtStart() {
    sut.viewDidLoad()
    sut.viewDidAppear(false)
    
    XCTAssertTrue(interactorSpy.startSessionCalled)
    XCTAssertTrue(audioControllerSpy.playAudioCalled)
  }
  
}
