//
//  RepositoriesService.swift
//  Diagrams
//
//  Created by Ihor Pedan on 25.12.2019.
//  Copyright © 2019 Ihor Pedan. All rights reserved.
//

import Foundation
import GitHubAPI
шьзщке 

protocol RepositoriesServiceInput {
  func countGitHubRepositoriesStatistics(handler: @escaping (RepositoriesStatistics) -> Void)
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
  func countGitHubRepositoriesStatistics(handler: @escaping (RepositoriesStatistics) -> Void) {
    let group = DispatchGroup()
    var swiftCount: Int = 0
    var objcCount: Int = 0
    var kotlinCount: Int = 0
    
    group.enter()
    RepositoriesAPI.searchRepositories(q: "Swift") { (list, error) in
      if list != nil {
        swiftCount = list!.totalCount ?? 0
      } else if error != nil {
        print("GitHub Swift failed")
      }
      group.leave()
    }
    
    group.enter()
    RepositoriesAPI.searchRepositories(q: "Objective-C") { (list, error) in
      if list != nil {
        objcCount = list!.totalCount ?? 0
      } else if error != nil {
        print("GitHub Objective-C failed")
      }
      group.leave()
    }
    
    group.enter()
    RepositoriesAPI.searchRepositories(q: "Kotlin") { (list, error) in
      if list != nil {
        kotlinCount = list!.totalCount ?? 0
      } else if error != nil {
        print("GitHub Kotlin failed")
      }
      group.leave()
    }
    
    group.notify(queue: .main) {
      handler(.init(objectiveC: objcCount, swift: swiftCount, kotlin: kotlinCount))
    }
  }
}
