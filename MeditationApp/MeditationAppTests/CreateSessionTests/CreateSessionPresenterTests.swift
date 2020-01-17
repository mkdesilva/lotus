//
//  CreateSessionPresenterTests.swift
//  MeditationAppTests
//
//  Created by Mihindu de Silva on 16/11/19.
//  Copyright © 2019 Mihindu de Silva. All rights reserved.
//

import XCTest

@testable import MeditationApp

final class CreateSessionPresenterTests: XCTestCase {
  
  // MARK: - Subject under test
  
  var sut: CreateSessionPresenter!
  var viewControllerSpy: CreateSessionViewControllerSpy!
  
  // MARK: - Test Lifecycle
  
  override func setUp() {
    super.setUp()
    setupCreateSessionPresenter()
  }
  
  // MARK: - Test Setup
  
  private func setupCreateSessionPresenter() {
    sut = CreateSessionPresenter()
    viewControllerSpy = CreateSessionViewControllerSpy()
    sut.viewController = viewControllerSpy
  }
  
  // MARK: - Test Doubles
  
  final class CreateSessionViewControllerSpy: CreateSessionViewControllerInterface {

    var displaySetDurationCalled = false
    var setDurationViewModel: CreateSession.SetDuration.ViewModel!
    
    func displaySetDuration(viewModel: CreateSession.SetDuration.ViewModel) {
      displaySetDurationCalled = true
      setDurationViewModel = viewModel
    }
  }
  
  // MARK: - Tests
  
  func testPresentSetDurationDisplaysSetDuration() {
    // Given
    let response = CreateSession.SetDuration.Response(duration: Duration(hours: 5, minutes: 5))
    
    // When
    sut.presentSetDuration(response: response)
    
    // Then
    XCTAssertTrue(viewControllerSpy.displaySetDurationCalled)
    XCTAssertEqual(viewControllerSpy.setDurationViewModel.durationTitle, "5h 5m")
  }
  
  func testPresentSetDurationWhenHoursIsZeroShouldOmitHours() {
    // Given
    let response = CreateSession.SetDuration.Response(duration: Duration(hours: 0, minutes: 43))
    
    // When
    sut.presentSetDuration(response: response)
    
    // Then
    XCTAssertEqual(viewControllerSpy.setDurationViewModel.durationTitle, "43m")
  }
  
  func testPresentSetDurationWhenMinutesIsZeroShouldOmitMinutes() {
    // Given
    let response = CreateSession.SetDuration.Response(duration: Duration(hours: 2, minutes: 0))
    
    // When
    sut.presentSetDuration(response: response)
    
    // Then
    XCTAssertEqual(viewControllerSpy.setDurationViewModel.durationTitle, "2h")
  }
  
}
