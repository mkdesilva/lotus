//
//  HistoryInteractor.swift
//  Lotus
//
//  Created by Mihindu de Silva on 30/8/21.
//  Copyright © 2021 Mihindu de Silva. All rights reserved.
//

import Foundation

protocol HistoryInteractorInterface {
  var sessions: [History.Session] { get set }

  func getSessions(request: History.GetSessions.Request)
}

final class HistoryInteractor: HistoryInteractorInterface {
  var sessions: [History.Session] = []
  
  func getSessions(request: History.GetSessions.Request) {
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .medium
    dateFormatter.timeStyle = .short
    print(DefaultsManager.shared.sessions)
    sessions = DefaultsManager.shared.sessions.map({ stats in
      History.Session(date: dateFormatter.string(
                        from: stats.date
      ),
                      duration: SessionDuration(
                        timeInterval: stats.duration).fullDescription,
                      notes: nil)
    })
  }
}
