//
//  BuildViewModel.swift
//  transformers
//
//  Created by Noah budarf on 2020-06-23.
//  Copyright © 2020 Noah budarf. All rights reserved.
//

import Foundation

class BuildViewModel: ObservableObject {
    var newTransformer: TransformerToCreate = TransformerToCreate()
    var pieChart: PieChart

    
    init() {
        self.pieChart = PieChart(newTransformer: newTransformer)
    }
}

extension BuildViewModel {
    func currentTransformerPower() -> Int {
        return newTransformer.strength + newTransformer.intelligence + newTransformer.speed + newTransformer.endurance + newTransformer.firepower
    }
    
    func totalPowerText() -> String {
        return "Total Power: \(currentTransformerPower())"
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
