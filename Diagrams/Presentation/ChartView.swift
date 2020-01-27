//
//  ChartView.swift
//  Diagrams
//
//  Created by Ihor Pedan on 24.12.2019.
//  Copyright © 2019 Ihor Pedan. All rights reserved.
//

import SwiftUI
import SwiftUICharts

struct ChartView: View {
  @EnvironmentObject var viewModel: MainViewModel
  
  var body: some View {
    switch viewModel.selectedChart {
    case .pie:
      let stats = self.viewModel.pieData
      let legend = "Objective-C - \(stats.objectiveC)\nSwift - \(stats.swift)\nKotlin - \(stats.kotlin)"
      return AnyView(
        GeometryReader { geometry in
          PieChartView(data: stats.array,
                       title: "Repositories stats",
                       legend: legend,
                       form: geometry.size,
                       dropShadow: false)
        }.padding()
      )
    case .bar:
      let stats = viewModel.barData
      let legend = "Apple - \(stats.apple)\nbitcoin - \(stats.bitcoin)\nnginx - \(stats.nginx)"
      return AnyView(
        GeometryReader { geometry in
          BarChartView(data: stats.array,
                       title: "News stats",
                       legend: legend,
                       form: geometry.size,
                       dropShadow: false)
        }.padding()
      )
    case .line:
      let histogram = Histogram()
      return AnyView(LineView(data: Array(histogram.histogram.values), title: "").padding())
    }
  }
}
