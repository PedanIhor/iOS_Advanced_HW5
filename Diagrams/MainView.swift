//
//  MainView.swift
//  Diagrams
//
//  Created by Ihor Pedan on 24.12.2019.
//  Copyright © 2019 Ihor Pedan. All rights reserved.
//

import SwiftUI

enum Chart: String, CaseIterable, Identifiable {
  case pie = "Pie"
  case bar = "Bar"
  case line = "Line"
  
  var id: String { rawValue }
}

struct MainView: View {
  @EnvironmentObject var viewModel: MainViewModel
  
  var body: some View {
    let selectedChart = Binding<Chart>.init(get: { self.viewModel.selectedChart },
                                            set: { self.viewModel.selectedChart = $0 })
    return NavigationView {
      VStack {
        Picker(selection: selectedChart, label: Text("3 source of charts")) {
          ForEach(Chart.allCases) {
            Text($0.rawValue).tag($0)
          }
        }.pickerStyle(SegmentedPickerStyle())
        ChartView().environmentObject(viewModel)
        Spacer()
      }
      .navigationBarTitle("Diagrams")
      .navigationBarItems(trailing: Button(action: {
        OverlayCoordinator.shared.toggleOverlay()
      }, label: {
        Text("Summary")
      }))
    }
  }
}
