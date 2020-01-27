//
//  ArticlesService.swift
//  Diagrams
//
//  Created by Ihor Pedan on 25.12.2019.
//  Copyright © 2019 Ihor Pedan. All rights reserved.
//

import Foundation
import News
import Combine

protocol ArticlesServiceInput {
  func countArticlesStatistics() -> AnyPublisher<ArticlesStatistics, DiagramsError>
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
  
  func countArticlesStatistics() -> AnyPublisher<ArticlesStatistics, DiagramsError> {
    let appleFuture = futureForSearchQuery(q: "apple")
    let bitcoinFuture = futureForSearchQuery(q: "bitcoin")
    let nginxFuture = futureForSearchQuery(q: "nginx")

    return Publishers.Zip3(appleFuture, bitcoinFuture, nginxFuture)
      .compactMap { ArticlesStatistics(apple: $0.0, bitcoin: $0.1, nginx: $0.2) }
      .eraseToAnyPublisher()
  }
  
  private func futureForSearchQuery(q: String) -> Future<Int, DiagramsError> {
    Future<Int, DiagramsError> { [unowned self] promise in
      ArticlesAPI.everythingGet(q: q, from: self.currentDate, sortBy: "publishedAt", apiKey: self.apiKey) { (list, error) in
        if list != nil {
          promise(.success(list!.totalResults ?? 0))
        } else if error != nil {
          promise(.failure(.newsService(error!.localizedDescription)))
        }
      }
    }
  }
}
