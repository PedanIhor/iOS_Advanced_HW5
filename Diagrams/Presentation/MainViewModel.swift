//
//  MainViewModel.swift
//  Diagrams
//
//  Created by Ihor Pedan on 24.12.2019.
//  Copyright © 2019 Ihor Pedan. All rights reserved.
//

import Foundation
import Combine

final class MainViewModel: ObservableObject {
  @Published var selectedChart: Chart = .pie
  @Published var pieData = RepositoriesStatistics.zero
  @Published var barData = ArticlesStatistics.zero
  
  private var bag: [AnyCancellable] = []
  private let repositoriesService: RepositoriesServiceInput
  private let articlesService: ArticlesServiceInput
  
  init(repositoriesService: RepositoriesServiceInput,
       articlesService: ArticlesServiceInput) {
    self.repositoriesService = repositoriesService
    self.articlesService = articlesService
    
    repositoriesService.countGitHubRepositoriesStatistics()
      .sink(
        receiveCompletion: { print($0) },
        receiveValue: { [unowned self] value in self.pieData = value }
    )
      .store(in: &bag)
    
//    repositoriesService.countGitHubRepositoriesStatistics { [weak self] (stats) in
//      self?.pieData = stats
//    }
    
    articlesService.countArticlesStatistics { [weak self] (stats) in
      self?.barData = stats
    }
  }
}
