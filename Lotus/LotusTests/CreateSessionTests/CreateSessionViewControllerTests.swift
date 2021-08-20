//
//  CreateSessionViewControllerTests.swift
//  LotusTests
//
//  Created by Mihindu de Silva on 16/11/19.
//  Copyright © 2019 Mihindu de Silva. All rights reserved.
//

import XCTest

@testable import Lotus

final class CreateSessionViewControllerTests: XCTestCase {

  // MARK: - Subject under test
  
  var sut: CreateSessionViewController!
  
  // MARK: - Test Lifecycle
  
  override func setUp() {
    super.setUp()
    setupCreateSessionViewController()
  }
  
  override func tearDown() {
    sut = nil
    super.tearDown()
  }
  
  // MARK: - Test setup
  
  private func setupCreateSessionViewController() {
    sut = CreateSessionViewController()
    _ = sut.view
  }
  
  // MARK: - Test Doubles
  
  final class CreateSessionInteractorSpy: CreateSessionInteractorInterface {
  
    var sessionDuration: SessionDuration?
    
    var setDurationCalled = false
    var getInitialDurationCalled = false
    
    func setDuration(request: CreateSession.ShowDuration.Request) {
      setDurationCalled = true
    }
    
    func getInitialDuration(request: CreateSession.GetInitialDuration.Request) {
      getInitialDurationCalled = true
    }
    
    func storeDuration(request: CreateSession.StoreDuration.Request) {}
  }
  
  final class CreateSessionRouterSpy: CreateSessionRouterInterface {
    
    var navigateToDurationPickerCalled = false
    var navigateToInProgressSceneCalled = false
    
    func navigateToDurationPicker(duration: SessionDuration?) {
      navigateToDurationPickerCalled = true
    }
    
    func navigateToInProgressScene(duration: SessionDuration) {
      navigateToInProgressSceneCalled = true
    }
  }
  
  // MARK: - Tests
  
  func testCreateSessionViewControllerSetupProperly() {
    XCTAssertNotNil(sut.createSessionView)
    XCTAssertNotNil(sut.interactor)
    XCTAssertNotNil(sut.router)
  }
  
  func testRouteToBeginSessionShouldCallNavigateToInProgressScene() {
    // Given
      let routerSpy = CreateSessionRouterSpy()
      sut.router = routerSpy
      
      // When
      sut.routeToBeginSession(duration: SessionDuration(hours: 0, minutes: 0))
      
      // Then
      XCTAssertTrue(routerSpy.navigateToInProgressSceneCalled)
  }
  
  func testBeginSessionWithoutPickerSetShouldNotRouteToBeginSession() {
    let routerSpy = CreateSessionRouterSpy()
    sut.router = routerSpy
    let interactor = CreateSessionInteractorSpy()
    interactor.sessionDuration = SessionDuration(seconds: 0)
    sut.interactor = interactor
    sut.viewDidLoad()
    
    sut.beginSession()
    
    XCTAssertFalse(routerSpy.navigateToInProgressSceneCalled)
  }
  
}
