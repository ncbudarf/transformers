//
//  BuildViewModel.swift
//  transformers
//
//  Created by Noah budarf on 2020-06-23.
//  Copyright © 2020 Noah budarf. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

class BuildViewModel: ObservableObject {
    @Published var newTransformer: NewTransformer
    @Published var pieChart: PieChart
    @Published var currentFactionColor: Color
    @Published var statViewModels: [StatViewModel]
    
    @State var submitButtonDisabled: Bool = false
        
    let request: Request = Request()
    
    var autobotColor: Color {
        return newTransformer.autobotColor
    }
    
    var deceptaconColor: Color {
        return newTransformer.deceptaconColor
    }
    
    var transformerName: String {
        return newTransformer.name
    }
    
    init(newTransformer: NewTransformer) {
        self.newTransformer = newTransformer
        self.pieChart = PieChart(newTransformer: newTransformer)
        self.currentFactionColor = newTransformer.currentColor
        self.statViewModels = newTransformer.statViewModels
    }
}

extension BuildViewModel {
    func rerollTransformer(to faction: TransformerFaction = Bool.random() ? .autobot : .deceptacon) {
        newTransformer = NewTransformer(team: faction)
        pieChart = PieChart(newTransformer: newTransformer)
        currentFactionColor = newTransformer.currentColor
        statViewModels = newTransformer.statViewModels
    }
}

extension BuildViewModel {
    func totalPowerText() -> String {
        return "Total Power: \(self.newTransformer.power)"
    }
}

extension BuildViewModel {
    func reRollButtonText() -> String {
        return "Reroll"
    }
}

extension BuildViewModel {
    func submitButtonText() -> String {
        return "Submit"
    }
}
