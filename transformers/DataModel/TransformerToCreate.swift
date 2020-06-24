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
//    
//    let deceptaconNames = ["Megatron", "Starscream", "Barricade", "Frenzy", "Thundercracker", "Skywarp", "Jetstorm", "Brawl", "Devastator", "Bonecrusher"] //TODO Add more names
//    let autobotNames = ["Optimus Prime", "Ratchet", "Arcee", "Bumblebee", "Bulkhead", "Smokescreen", "Wheeljack", "Ultra Magnus", "Cliffjumper", "Predaking"] //TODO Add more names
    
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
    
    init(team: String) {
        self.team = team
        self.name = "Megatron"
        self.strength = Int.random(in: 1 ..< 10)
        self.intelligence = Int.random(in: 1 ..< 10)
        self.speed = Int.random(in: 1 ..< 10)
        self.endurance = Int.random(in: 1 ..< 10)
        self.rank = Int.random(in: 0 ..< 10)
        self.courage = Int.random(in: 1 ..< 10)
        self.firepower = Int.random(in: 1 ..< 10)
        self.skill = Int.random(in: 1 ..< 10)
    }
    
    init() {
        self.team = "D"
        self.name = "Random Name"
        self.strength = Int.random(in: 1 ..< 10)
        self.intelligence = Int.random(in: 1 ..< 10)
        self.speed = Int.random(in: 1 ..< 10)
        self.endurance = Int.random(in: 1 ..< 10)
        self.rank = Int.random(in: 0 ..< 10)
        self.courage = Int.random(in: 1 ..< 10)
        self.firepower = Int.random(in: 1 ..< 10)
        self.skill = Int.random(in: 1 ..< 10)
    }
}
