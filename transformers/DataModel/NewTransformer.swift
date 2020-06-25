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

enum TransformerFaction {
    case autobot
    case deceptacon
}

private struct TransformerNames {
    let autobotNames = ["Optimus Prime", "Ratchet", "Arcee", "Bumblebee", "Bulkhead", "Smokescreen", "Wheeljack", "Ultra Magnus", "Cliffjumper", "Predaking"] //TODO Add more names
    let deceptaconNames = ["Megatron", "Starscream", "Barricade", "Frenzy", "Thundercracker", "Skywarp", "Jetstorm", "Brawl", "Devastator", "Bonecrusher"] //TODO Add more names
    
    public func randomName(for team: TransformerFaction) -> String {
        switch team {
        case .autobot:
            return autobotNames[Int.random(in: 0 ..< 10)]
        case .deceptacon:
            return deceptaconNames[Int.random(in: 0 ..< 10)]
        default:
            return autobotNames[Int.random(in: 0 ..< 10)]
        }
    }
}

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
    
    private var convertTeamEnumToString: String {
        switch team {
        case .autobot:
            return "A"
        case .deceptacon:
            return "D"
        default:
            return "A"
        }
    }
    
    let autobotColor: Color = .red
    let deceptaconColor: Color = .purple
    var currentColor: Color {
        switch team {
        case .autobot:
            return autobotColor
        case .deceptacon:
            return deceptaconColor
        default:
            return autobotColor
        }
    }
    
    private var statList: [Int] {
        return [strength, intelligence, speed, endurance, rank, courage, firepower, skill]
    }
    private let statNames: [String] = ["Str", "Int", "Spd", "End", "Rnk", "Crg", "Pow", "Skl"]
    var statViewModels: [StatViewModel] {
        var models: [StatViewModel] = []
        for (index, element) in statNames.enumerated() {
            models.append(StatViewModel(statName: element, statValue: statList[index], statColor: currentColor.opacity((1.0/Double(statNames.count))*Double(index+1))))
        }
        return models
    }
    
    init(team: TransformerFaction) {
        self.team = team
        self.name = TransformerNames().randomName(for: team)
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
