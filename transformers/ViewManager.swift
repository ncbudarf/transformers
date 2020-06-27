//
//  ViewManager.swift
//  transformers
//
//  Created by Noah budarf on 2020-06-25.
//  Copyright © 2020 Noah budarf. All rights reserved.
//

import Foundation
import SwiftUI

enum TransformerFaction {
    case autobot
    case deceptacon
}

class ViewManager {
    private let autobotNames = ["Optimus Prime", "Ratchet", "Arcee", "Bumblebee", "Bulkhead", "Smokescreen", "Wheeljack", "Ultra Magnus", "Cliffjumper", "Predaking"] //TODO Add more names
    private let deceptaconNames = ["Megatron", "Starscream", "Barricade", "Frenzy", "Thundercracker", "Skywarp", "Jetstorm", "Brawl", "Devastator", "Bonecrusher"] //TODO Add more names
    
    public let autobotColor: Color = .red
    public let deceptaconColor: Color = .purple
    
    public let statNames: [String] = ["Str", "Int", "Spd", "End", "Rnk", "Crg", "Pow", "Skl"]
    

}

extension ViewManager {
    public func randomName(for team: TransformerFaction) -> String {
        switch team {
        case .autobot:
            return autobotNames[Int.random(in: 0 ..< 10)]
        case .deceptacon:
            return deceptaconNames[Int.random(in: 0 ..< 10)]
        }
    }
}

extension ViewManager {
    public func currentColor(for team: TransformerFaction) -> Color {
        switch team {
        case .autobot:
            return ViewManager().autobotColor
        case .deceptacon:
            return ViewManager().deceptaconColor
        }
    }
    
    public func currentColor(for team: String) -> Color {
        switch team {
        case "A":
            return .red
        case "D":
            return .purple
        default:
            return .red
        }
    }
}

extension ViewManager {
    public func statList(for transformer: Transformer) -> [Int] {
        return [transformer.strength,
                transformer.intelligence,
                transformer.speed,
                transformer.endurance,
                transformer.rank,
                transformer.courage,
                transformer.firepower,
                transformer.skill]
    }
    
    public func statList(for transformer: NewTransformer) -> [Int] {
        return [transformer.strength,
                transformer.intelligence,
                transformer.speed,
                transformer.endurance,
                transformer.rank,
                transformer.courage,
                transformer.firepower,
                transformer.skill]
    }
}
