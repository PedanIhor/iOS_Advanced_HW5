//
//  SummaryView.swift
//  Diagrams
//
//  Created by Ihor Pedan on 15.01.2020.
//  Copyright © 2020 Ihor Pedan. All rights reserved.
//

import SwiftUI
import SwiftUICharts

struct SummaryView: View {
  @EnvironmentObject var viewModel: MainViewModel
  
  var body: some View {
    GeometryReader { proxy in
      VStack(alignment: .center, spacing: 24) {
        PieChartView(data: self.viewModel.pieData.array,
                     title: "Repositories stats")
          .padding([.top, .leading, .trailing])
        BarChartView(data: self.viewModel.barData.array,
                     title: "News stats")
          .padding([.leading, .trailing, .bottom])
      }.frame(maxWidth: proxy.size.width * 0.9, maxHeight: proxy.size.height * 0.9, alignment: .center)
        .background(Color(red: 0.4, green: 0, blue: 0))
        .cornerRadius(20)
        .onTapGesture {
          OverlayCoordinator.shared.toggleOverlay()
      }
    }
  }
}

