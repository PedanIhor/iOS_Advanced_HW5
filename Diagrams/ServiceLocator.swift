//
//  ServiceLocator.swift
//  Diagrams
//
//  Created by Ihor Pedan on 23.01.2020.
//  Copyright © 2020 Ihor Pedan. All rights reserved.
//

import Foundation

final class ServiceLocator {
  static let shared = ServiceLocator()
  private init() {}
  
  private var services: [String: Any] = [:]
  
  private func nameOfType<T>(_ type: T.Type) -> String {
    String(describing: type)
  }
  
  func addService<T>(_ service: T) {
    services[nameOfType(T.self)] = service
  }
  
  func getServiceOf<T>(_ type: T.Type) -> T? {
    services[nameOfType(type.self)] as? T
  }
}
