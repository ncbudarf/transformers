//
//  TransformerListCellViewModel.swift
//  transformers
//
//  Created by Noah budarf on 2020-06-25.
//  Copyright © 2020 Noah budarf. All rights reserved.
//

import Foundation
import SwiftUI


class TransformerListCellViewModel {
    let transformer: Transformer
    
    init(transformer: Transformer) {
        self.transformer = transformer
    }

    var transformerName: String {
        return transformer.name
    }
    
    var iconName: String {//TODO: This should probably moved into the ViewManager
        switch transformer.team {
        case "A":
            return "autobotButtonIcon"
        case "D":
            return "deceptaconButtonIcon"
        default:
            return "autobotButtonIcon"
        }
    }
    
    func currentColor() -> Color {
        return ViewManager().currentColor(for: transformer.team)
    }
    
    private var power: Int {
        return transformer.strength + transformer.intelligence + transformer.speed + transformer.endurance + transformer.firepower
    }

    func transformerPower() -> String {
        return "Total Power: \(power)"
    }
    
    var statViewModels: [StatViewModel] {
        var models: [StatViewModel] = []
        for (index, element) in ViewManager().statNames.enumerated() {
            models.append(StatViewModel(statName: element,
                                        statValue: ViewManager().statList(for: transformer)[index],
                                        statColor: statColor(at: index)))
        }
        return models
    }
    
    private func statColor(at index: Int) -> Color {
        return ViewManager()
            .currentColor(for: transformer.team)
            .opacity((1.0/Double(ViewManager().statNames.count))*Double(index+1))
    }
}
