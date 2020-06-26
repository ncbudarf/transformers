//
//  Transformer.swift
//  transformers
//
//  Created by Noah budarf on 2020-06-22.
//  Copyright © 2020 Noah budarf. All rights reserved.
//

import Foundation

struct Transformer: Codable {
    var id: String
    var name: String
    var team: String
    var strength: Int
    var intelligence: Int
    var speed: Int
    var endurance: Int
    var rank: Int
    var courage: Int
    var firepower: Int
    var skill: Int
    var team_icon: String
    
    func overallRating() -> Int {
        return strength + intelligence + speed + endurance + firepower
    }
}
