//
//  CreateSessionStore.swift
//  MeditationApp
//
//  Created by Mihindu de Silva on 8/11/19.
//  Copyright (c) 2019 Mihindu de Silva. All rights reserved.
//

import Foundation

protocol CreateSessionStoreProtocol {
  func getDuration(_ completion: @escaping (Duration) -> Void)
  func setDuration(duration: Duration, _ completion: @escaping (Result<Duration, CustomError>) -> Void)
  func getDefaultDuration(completion: @escaping (Duration) -> Void)
}

class CreateSessionStore: CreateSessionStoreProtocol {
  
  let defaultDuration = Duration(hours: 0, minutes: 15)
  
  func getDuration(_ completion: @escaping (Duration) -> Void) {
    let userDefaults = UserDefaults.standard
    
    if let data = userDefaults.value(forKey: .duration) as? Data {
      if let duration = try? PropertyListDecoder().decode(Duration.self, from: data) {
        completion(duration)
        return
      }
    }
    
    // If did not decode
    completion(defaultDuration)
  }
  
  func setDuration(duration: Duration, _ completion: @escaping (Result<Duration, CustomError>) -> Void) {
    let userDefaults = UserDefaults.standard
    
    if let encodedDuration = try? PropertyListEncoder().encode(duration) {
      userDefaults.set(encodedDuration, forKey: .duration)
      completion(.success(duration))
    } else {
      // Archive Error
      completion(.failure(.archiveFailed))
    }
  }
  
  func getDefaultDuration(completion: @escaping (Duration) -> Void) {
    completion(defaultDuration)
  }
}
