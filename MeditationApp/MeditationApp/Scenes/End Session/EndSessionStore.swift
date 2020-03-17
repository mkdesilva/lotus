//
//  EndSessionStore.swift
//  MeditationApp
//
//  Created by Mihindu de Silva on 5/3/20.
//  Copyright (c) 2020 Mihindu de Silva. All rights reserved.
//

import Foundation

/*

 The EndSessionStore class implements the EndSessionStoreProtocol.

 The source for the data could be a database, cache, or a web service.

 You may remove these comments from the file.

 */

class EndSessionStore: EndSessionStoreProtocol {
  func getData(_ completion: @escaping (Result<Entity, Error>) -> Void) {
    // Simulates an asynchronous background thread that calls back on the main thread after 2 seconds
    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
      completion(Result.success(Entity()))
    }
  }
}
