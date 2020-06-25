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
    
    var iconName: String {
        switch transformer.team {
        case "A":
            return "autobotButtonIcon"
        case "D":
            return "deceptaconButtonIcon"
        default:
            return "autobotButtonIcon"
        }
    }
    
    var currentColor: Color {
        switch transformer.team {
        case "A":
            return .red
        case "D":
            return .purple
        default:
            return .red
        }
    }
    
    private var power: Int {
        return transformer.strength + transformer.intelligence + transformer.speed + transformer.endurance + transformer.firepower
    }
    func transformerPower() -> String {
        return "Total Power: \(power)"
    }
    
    private var statList: [Int] {
        return [transformer.strength,
                transformer.intelligence,
                transformer.speed,
                transformer.endurance,
                transformer.rank,
                transformer.courage,
                transformer.firepower,
                transformer.skill]
    }
    private let statNames: [String] = ["Str", "Int", "Spd", "End", "Rnk", "Crg", "Pow", "Skl"]
    var statViewModels: [StatViewModel] {
        var models: [StatViewModel] = []
        for (index, element) in statNames.enumerated() {
            models.append(StatViewModel(statName: element, statValue: statList[index], statColor: currentColor.opacity((1.0/Double(statNames.count))*Double(index+1))))
        }
        return models
    }
}
