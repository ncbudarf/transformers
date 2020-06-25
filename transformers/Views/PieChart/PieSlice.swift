//
//  PieSlice.swift
//  transformers
//
//  Created by Noah budarf on 2020-06-23.
//  Copyright © 2020 Noah budarf. All rights reserved.
//

import Foundation
import SwiftUI

class PieSlice: Identifiable, ObservableObject {
    let id: UUID = UUID()
    @Published var pieRecipe: StatViewModel
    var annotation: String = ""
    var startAngle: Angle = .degrees(0)
    var endAngle: Angle = .degrees(0)
    
    init(viewModel: StatViewModel, startAngle: Angle, endAngle: Angle) {
        self.pieRecipe = viewModel
        self.annotation = String(viewModel.statValue)
        self.startAngle = startAngle
        self.endAngle = endAngle
    }
}
