//
//  ArticlesService.swift
//  Diagrams
//
//  Created by Ihor Pedan on 25.12.2019.
//  Copyright © 2019 Ihor Pedan. All rights reserved.
//

import Foundation
import News

protocol ArticlesServiceInput {
  func countArticlesStatistics(handler: @escaping (ArticlesStatistics) -> Void)
}

struct ArticlesStatistics {
  static var zero: ArticlesStatistics {
    return .init(apple: 0, bitcoin: 0, nginx: 0)
  }

  let apple: Int
  let bitcoin: Int
  let nginx: Int
  
  var array: [Int] { [apple, bitcoin, nginx] }
}

final class ArticlesService: ArticlesServiceInput {
  
  private let apiKey = "a9b0a70b40c7497fae2f6cff41567103"
  private lazy var currentDate: String = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    return formatter.string(from: Date())
  }()
  
  func countArticlesStatistics(handler: @escaping (ArticlesStatistics) -> Void) {
    let group = DispatchGroup()
    var appleCount: Int = 0
    var bitcoinCount: Int = 0
    var nginxCount: Int = 0

    group.enter()
    ArticlesAPI.everythingGet(q: "apple", from: currentDate, sortBy: "publishedAt", apiKey: apiKey) { (list, error) in
      if list != nil {
        appleCount = list!.totalResults ?? 0
      } else if error != nil {
        print("News apple failed")
        print(error!.localizedDescription)
        print("=-=-=-=-=-=-=-=-=-=-=-=-=-=-=")
      }
      group.leave()
    }

    group.enter()
    ArticlesAPI.everythingGet(q: "bitcoin", from: currentDate, sortBy: "publishedAt", apiKey: apiKey) { (list, error) in
      if list != nil {
        bitcoinCount = list!.totalResults ?? 0
      } else if error != nil {
        print("News bitcoin failed")
        print(error!.localizedDescription)
        print("=-=-=-=-=-=-=-=-=-=-=-=-=-=-=")
      }
      group.leave()
    }

    group.enter()
    ArticlesAPI.everythingGet(q: "nginx", from: currentDate, sortBy: "publishedAt", apiKey: apiKey) { (list, error) in
      if list != nil {
        nginxCount = list!.totalResults ?? 0
      } else if error != nil {
        print("News nginx failed")
        print(error!.localizedDescription)
        print("=-=-=-=-=-=-=-=-=-=-=-=-=-=-=")
      }
      group.leave()
    }

    group.notify(queue: .main) {
      handler(.init(apple: appleCount, bitcoin: bitcoinCount, nginx: nginxCount))
    }
  }
}
