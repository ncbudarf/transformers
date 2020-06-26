//
//  NewTransformer.swift
//  transformers
//
//  Created by Noah budarf on 2020-06-24.
//  Copyright © 2020 Noah budarf. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

class NewTransformer {
    var name: String
    var strength: Int
    var intelligence: Int
    var speed: Int
    var endurance: Int
    var rank: Int
    var courage: Int
    var firepower: Int
    var skill: Int
    var team: TransformerFaction
    
    var power: Int {
        return self.strength + self.intelligence + self.speed + self.endurance + self.firepower
    }
    
    public var convertTeamEnumToString: String {
        switch team {
        case .autobot:
            return "A"
        case .deceptacon:
            return "D"
        default:
            return "A"
        }
    }

    var statViewModels: [StatViewModel] {//TODO: This should probably be moved into the ViewManager
        var models: [StatViewModel] = []
        for (index, element) in ViewManager().statNames.enumerated() {
            models.append(StatViewModel(statName: element,
                                        statValue: ViewManager().statList(for: self)[index],
                                        statColor: ViewManager()
                    .currentColor(for: team)
                    .opacity((1.0/Double(ViewManager().statNames.count))*Double(index+1))))
        }
        return models
    }
    
    init(team: TransformerFaction) {
        self.team = team
        self.name = ViewManager().randomName(for: team)
        self.strength = Int.random(in: 1 ..< 10)
        self.intelligence = Int.random(in: 1 ..< 10)
        self.speed = Int.random(in: 1 ..< 10)
        self.endurance = Int.random(in: 1 ..< 10)
        self.rank = Int.random(in: 1 ..< 10)
        self.courage = Int.random(in: 1 ..< 10)
        self.firepower = Int.random(in: 1 ..< 10)
        self.skill = Int.random(in: 1 ..< 10)
    }
}

extension NewTransformer {
    func convertToTransformerToCreate() -> TransformerToCreate {
        return TransformerToCreate(name: name, strength: strength, intelligence: intelligence, speed: speed, endurance: endurance, rank: rank, courage: courage, firepower: firepower, skill: skill, team: convertTeamEnumToString)
    }
}
