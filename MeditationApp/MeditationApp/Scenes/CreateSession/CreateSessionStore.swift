//
//  CreateSessionStore.swift
//  MeditationApp
//
//  Created by Mihindu de Silva on 8/11/19.
//  Copyright (c) 2019 Mihindu de Silva. All rights reserved.
//

import Foundation

protocol CreateSessionStoreProtocol {
  func getDuration(_ completion: @escaping (SessionDuration) -> Void)
  func setDuration(duration: SessionDuration, _ completion: @escaping (Result<SessionDuration, CustomError>) -> Void)
  func getDefaultDuration(completion: @escaping (SessionDuration) -> Void)
}

class CreateSessionStore: CreateSessionStoreProtocol {
  
  let defaultDuration = SessionDuration(hours: 0, minutes: 15)
  
  func getDuration(_ completion: @escaping (SessionDuration) -> Void) {
    let userDefaults = UserDefaults.standard
    
    if let data = userDefaults.value(forKey: .duration) as? Data {
      if let duration = try? PropertyListDecoder().decode(SessionDuration.self, from: data) {
        completion(duration)
        return
      }
    }
    
    // If did not decode
    completion(defaultDuration)
  }
  
  func setDuration(duration: SessionDuration, _ completion: @escaping (Result<SessionDuration, CustomError>) -> Void) {
    let userDefaults = UserDefaults.standard
    
    if let encodedDuration = try? PropertyListEncoder().encode(duration) {
      userDefaults.set(encodedDuration, forKey: .duration)
      completion(.success(duration))
    } else {
      // Archive Error
      completion(.failure(.archiveFailed))
    }
  }
  
  func getDefaultDuration(completion: @escaping (SessionDuration) -> Void) {
    completion(defaultDuration)
  }
}
