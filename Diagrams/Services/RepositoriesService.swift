//
//  RepositoriesService.swift
//  Diagrams
//
//  Created by Ihor Pedan on 25.12.2019.
//  Copyright © 2019 Ihor Pedan. All rights reserved.
//

import Foundation
import GitHubAPI
import Combine

protocol RepositoriesServiceInput {
  func countGitHubRepositoriesStatistics() -> AnyPublisher<RepositoriesStatistics, DiagramsError>
}

struct RepositoriesStatistics {
  static var zero: RepositoriesStatistics {
    return .init(objectiveC: 0, swift: 0, kotlin: 0)
  }
  
  let objectiveC: Int
  let swift: Int
  let kotlin: Int
  
  var array: [Int] { [objectiveC, swift, kotlin] }
}

final class RepositoriesService: RepositoriesServiceInput {
  private var bag: [AnyCancellable] = []
  
  func countGitHubRepositoriesStatistics() -> AnyPublisher<RepositoriesStatistics, DiagramsError> {
    let swiftFuture = futureForSearchQuery(q: "Swift")
    let objcFuture = futureForSearchQuery(q: "Objective-C")
    let kotlinFuture = futureForSearchQuery(q: "Kotlin")
    
    return Publishers.Zip3(swiftFuture, objcFuture, kotlinFuture)
      .compactMap { .init(objectiveC: $0.1, swift: $0.0, kotlin: $0.2) }
      .eraseToAnyPublisher()
  }
  
  private func futureForSearchQuery(q: String) -> Future<Int, DiagramsError> {
    Future<Int, DiagramsError> { promise in
      RepositoriesAPI.searchRepositories(q: q) { (list, error) in
        if list != nil {
          promise(.success(list!.totalCount ?? 0))
        } else if error != nil {
          promise(.failure(.gitHubService(error!.localizedDescription)))
        }
      }
    }
  }
}
