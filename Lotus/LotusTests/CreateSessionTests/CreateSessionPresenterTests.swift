//
//  CreateSessionPresenterTests.swift
//  LotusTests
//
//  Created by Mihindu de Silva on 16/11/19.
//  Copyright © 2019 Mihindu de Silva. All rights reserved.
//

import XCTest

@testable import Lotus

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
    
    func displayInitialDuration(viewModel: CreateSession.SetDuration.ViewModel) {
      displaySetDurationCalled = true
      setDurationViewModel = viewModel
    }
  }
  
  // MARK: - Tests
  
  func testPresentSetDurationDisplaysSetDuration() {
    // Given
    let response = CreateSession.SetDuration.Response(duration: SessionDuration(hours: 5, minutes: 3))
    
    // When
    sut.presentInitialDuration(response: response)
    
    // Then
    XCTAssertTrue(viewControllerSpy.displaySetDurationCalled)
    XCTAssertEqual(viewControllerSpy.setDurationViewModel.hours, 5)
    XCTAssertEqual(viewControllerSpy.setDurationViewModel.minutes, 3)
    XCTAssertEqual(viewControllerSpy.setDurationViewModel.seconds, 0)
  }
  
  func testPresentSetDurationWhenHoursIsZeroShouldOmitHours() {
    // Given
    let response = CreateSession.SetDuration.Response(duration: SessionDuration(hours: 0, minutes: 43))
    
    // When
    sut.presentInitialDuration(response: response)
    
    // Then
    XCTAssertEqual(viewControllerSpy.setDurationViewModel.minutes, 43)
  }
  
  func testPresentSetDurationWhenMinutesIsZeroShouldOmitMinutes() {
    // Given
    let response = CreateSession.SetDuration.Response(duration: SessionDuration(hours: 2, minutes: 0))
    
    // When
    sut.presentInitialDuration(response: response)
    
    // Then
    XCTAssertEqual(viewControllerSpy.setDurationViewModel.hours, 2)
  }
  
}
