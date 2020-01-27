//
//  DiagramsError.swift
//  Diagrams
//
//  Created by Ihor Pedan on 27.01.2020.
//  Copyright © 2020 Ihor Pedan. All rights reserved.
//

import Foundation

enum DiagramsError: Error {
  case gitHubService(_ msg: String)
  case newsService(_ msg: String)
}
