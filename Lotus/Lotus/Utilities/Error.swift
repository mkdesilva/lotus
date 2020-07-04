//
//  Error.swift
//  Lotus
//
//  Created by Mihindu de Silva on 27/12/19.
//  Copyright © 2019 Mihindu de Silva. All rights reserved.
//

enum CustomError: String, Error {
  case generic = "Something went wrong."
  case archiveFailed
}

enum Content<T> {
  case customError(CustomError)
  case success(data: T)
}
