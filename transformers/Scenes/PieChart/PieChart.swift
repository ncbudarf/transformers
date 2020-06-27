//
//  PieChart.swift
//  transformers
//
//  Created by Noah budarf on 2020-06-23.
//  Copyright © 2020 Noah budarf. All rights reserved.
//

import Foundation
import SwiftUI

class PieChart: ObservableObject {
    @Published private(set) var data: [PieSlice] = []
    var startAngle: Int = -90
    
    init(newTransformer: NewTransformer) {
        let models = newTransformer.statViewModels
        let interval = 360/newTransformer.statViewModels.count
        for (index, element) in models.enumerated() {
            data.append(PieSlice(viewModel: element,
            startAngle: .degrees(startAngle(at: index, interval: interval)),
            endAngle: .degrees(endAngle(at: index, interval: interval))))
        }
    }
    
    private func startAngle(at index: Int, interval: Int) -> Double {
        var originalAngle: Int = startAngle
        originalAngle += interval*index
        return Double(originalAngle)
    }
    
    private func endAngle(at index: Int, interval: Int) -> Double {
        var originalAngle: Int = startAngle
        originalAngle += interval*(index+1)
        return Double(originalAngle)
    }
    
}
