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
    
    init(newTransformer: TransformerToCreate) {
        //TODO:This is a bad way of doing it
        data.append(PieSlice(pieRecipe: PieRecipe(title: "Strength", value: newTransformer.strength, color: .red),
                             startAngle: .degrees(startAngle(at: 0, interval: 72)),
                             endAngle: .degrees(endAngle(at: 0, interval: 72))))
        data.append(PieSlice(pieRecipe: PieRecipe(title: "Intelligence", value: newTransformer.intelligence, color: .blue),
                             startAngle: .degrees(startAngle(at: 1, interval: 72)),
                             endAngle: .degrees(endAngle(at: 1, interval: 72))))
        data.append(PieSlice(pieRecipe: PieRecipe(title: "Speed", value: newTransformer.speed, color: .green),
                             startAngle: .degrees(startAngle(at: 2, interval: 72)),
                             endAngle: .degrees(endAngle(at: 2, interval: 72))))
        data.append(PieSlice(pieRecipe: PieRecipe(title: "Endurance", value: newTransformer.endurance, color: .yellow),
                             startAngle: .degrees(startAngle(at: 3, interval: 72)),
                             endAngle: .degrees(endAngle(at: 3, interval: 72))))
        data.append(PieSlice(pieRecipe: PieRecipe(title: "Firepower", value: newTransformer.firepower, color: .gray),
                             startAngle: .degrees(startAngle(at: 4, interval: 72)),
                             endAngle: .degrees(endAngle(at: 4, interval: 72))))
    }
    
    private func startAngle(at index: Int, interval: Int) -> Double {//TODO: interval is basically a magic number
        var originalAngle: Int = startAngle
        originalAngle += interval*index
        return Double(originalAngle)
    }
    
    private func endAngle(at index: Int, interval: Int) -> Double {//TODO: interval is basically a magic number
        var originalAngle: Int = startAngle
        originalAngle += interval*(index+1)
        return Double(originalAngle)
    }
    
}
