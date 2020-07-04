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
    
    func setDuration(request: CreateSession.SetDuration.Request) {
      setDurationCalled = true
    }
    
    func getInitialDuration(request: CreateSession.GetInitialDuration.Request) {
      getInitialDurationCalled = true
    }
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
  
  func testDisplaySetDurationShouldDisplayDurationInButton() {
    // Given
    let viewModel = CreateSession.SetDuration.ViewModel(durationTitle: "5h 4m")
    
    // When
    sut.displaySetDuration(viewModel: viewModel)
    
    // Then
    XCTAssertNotNil(sut.createSessionView.durationButton.titleLabel)
    XCTAssertNotNil(sut.createSessionView.durationButton.titleLabel!.text)
    XCTAssertEqual(sut.createSessionView.durationButton.titleLabel!.text!, "5h 4m")
  }
  
  func testShowDurationPickerShouldCallNavigateToDurationPicker() {
    // Given
    let routerSpy = CreateSessionRouterSpy()
    sut.router = routerSpy
    
    // When
    sut.showDurationPicker()
    
    // Then
    XCTAssertTrue(routerSpy.navigateToDurationPickerCalled)
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
  
}
