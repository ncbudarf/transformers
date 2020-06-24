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
    var pieRecipe: PieRecipe
    var annotation: String = ""
    var startAngle: Angle = .degrees(0)
    var endAngle: Angle = .degrees(0)
    
    init(pieRecipe: PieRecipe, startAngle: Angle, endAngle: Angle) {
        self.pieRecipe = pieRecipe
        self.annotation = String(pieRecipe.value)
        self.startAngle = startAngle
        self.endAngle = endAngle
    }
}
