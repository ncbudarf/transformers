//
//  TransformerToCreate.swift
//  transformers
//
//  Created by Noah budarf on 2020-06-22.
//  Copyright © 2020 Noah budarf. All rights reserved.
//

import Foundation

struct TransformerToCreate: Encodable {
    var name: String
    var strength: Int
    var intelligence: Int
    var speed: Int
    var endurance: Int
    var rank: Int
    var courage: Int
    var firepower: Int
    var skill: Int
    var team: String
    
    init(name: String,
         strength: Int,
         intelligence: Int,
         speed: Int,
         endurance: Int,
         rank: Int,
         courage: Int,
         firepower: Int,
         skill: Int,
         team: String) {
        
        self.name = name
        self.strength = strength
        self.intelligence = intelligence
        self.speed = speed
        self.endurance = endurance
        self.rank = rank
        self.courage = courage
        self.firepower = firepower
        self.skill = skill
        self.team = team
    }
}
