//
//  CreateSessionInteractorTests.swift
//  MeditationAppTests
//
//  Created by Mihindu de Silva on 16/11/19.
//  Copyright © 2019 Mihindu de Silva. All rights reserved.
//

import XCTest

@testable import MeditationApp

final class CreateSessionInteractorTests: XCTestCase {
  
  // MARK: - Subject under test
  
  var sut: CreateSessionInteractor!
  var presenterSpy: CreateSessionPresenterSpy!
  var workerSpy: CreateSessionWorkerSpy!
  
  // MARK: - Test lifecycle
  
  override func setUp() {
    super.setUp()
    setupCreateSessionInteractor()
  }
  
  override func tearDown() {
    sut = nil
    presenterSpy = nil
    workerSpy = nil
    super.tearDown()
  }
  
  // MARK: - Test setup
  
  private func setupCreateSessionInteractor() {
    sut = CreateSessionInteractor()
    presenterSpy = CreateSessionPresenterSpy()
    workerSpy = CreateSessionWorkerSpy(store: CreateSessionStore())
    sut.worker = workerSpy
    sut.presenter = presenterSpy
  }
  
  // MARK: - Test doubles
  
  final class CreateSessionPresenterSpy: CreateSessionPresenterInterface {
    
    var presentSetDurationCalled = false
    func presentSetDuration(response: CreateSession.SetDuration.Response) {
      presentSetDurationCalled = true
    }
  }
  
  final class CreateSessionWorkerSpy: CreateSessionWorker {
    
    var getDurationCalled = false
    var setDurationCalled = false
    
    override func getDuration(completion: @escaping (Duration) -> Void) {
      getDurationCalled = true
      completion(Duration(hours: 0, minutes: 0))
    }
    
    override func setDuration(_ duration: Duration, completion: @escaping (Result<Duration, CustomError>) -> Void) {
      setDurationCalled = true
      completion(.success(Duration(hours: 5, minutes: 5)))
    }
  }
  
  // MARK: - Tests
  
  func testGetInitialDurationAsksWorkerToGetDurationAndSetDuration() {
    // Given
    let request = CreateSession.GetInitialDuration.Request()
    
    // When
    sut.getInitialDuration(request: request)
    
    // Then
    XCTAssertTrue(workerSpy.getDurationCalled)
    XCTAssertTrue(workerSpy.setDurationCalled)
  }
  
  func testSetDurationAsksPresenterToPresentSetDuration() {
    // Given
    let request = CreateSession.SetDuration.Request(duration: Duration(hours: 5, minutes: 3))
    
    // When
    sut.setDuration(request: request)
    
    // Then
    XCTAssertTrue(presenterSpy.presentSetDurationCalled)
    XCTAssertEqual(sut.sessionDuration, Duration(hours: 5, minutes: 3))
  }
  
}
