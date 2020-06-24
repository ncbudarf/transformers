//
//  PieChartView.swift
//  transformers
//
//  Created by Noah budarf on 2020-06-23.
//  Copyright © 2020 Noah budarf. All rights reserved.
//

import SwiftUI
import Combine

struct PieChartView: View {
    var pieChart: PieChart
    
    var body: some View {
        GeometryReader { geometry in
            self.makePieChart(geometry, pieSlices: self.pieChart.data)
        }
    }
    
    func makePieChart(_ geometry: GeometryProxy, pieSlices: [PieSlice]) -> some View {
        return ZStack {
            ForEach(0..<pieSlices.count, id: \.self) { index in
                PieChartSliceView(geometry: geometry, pieSlice: pieSlices[index])
            }
        }
    }
}
