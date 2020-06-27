//
//  BattleManager.swift
//  transformers
//
//  Created by Noah budarf on 2020-06-26.
//  Copyright © 2020 Noah budarf. All rights reserved.
//

import Foundation

class Victories {
    var player: Int = 0
    var computer: Int = 0
}

class BattleManager {
    var playerTeam: [Transformer] = []
    var computerTeam: [Transformer] = []
    var victories: Victories = Victories()
    var primeVsPredaking: Bool = false
    
    typealias CompletionHandler = (_ victories: Victories) -> Void
    
    init(playerFaction: TransformerFaction) {
        guard
            let playerTeam = getTransformers(from: playerFaction),
            !playerTeam.isEmpty,
            let computerTeam = getTransformers(from: computerFaction(from: playerFaction)),
            !computerTeam.isEmpty else { return }
        self.playerTeam = playerTeam
        self.computerTeam = computerTeam
    }
    
    private func computerFaction(from playerFaction: TransformerFaction) -> TransformerFaction {
        switch playerFaction {
        case .autobot:
            return .deceptacon
        case .deceptacon:
            return .autobot
        }
    }
    
    private func getTransformers(from faction: TransformerFaction) -> [Transformer]? {
        let transformers: [Transformer] = DataManager().decodeTransformerList()
        return transformers.filter { transformerFaction(for: $0.team) == faction }
    }
    
    private func transformerFaction(for team: String) -> TransformerFaction {
        switch team {
        case "A":
            return .autobot
        case "D":
            return .deceptacon
        default:
            return .autobot
        }
    }
}

extension BattleManager {
    func arena(completionHandler: @escaping CompletionHandler) {
        //1. Order Teams by rank
        playerTeam = orderTeamByRank(team: playerTeam)
        computerTeam = orderTeamByRank(team: computerTeam)
        
        //2. battle until one team is 'destroyed'
        battle(pTeam: playerTeam, cTeam: computerTeam)
        
        //3. Team that won the most battles is the winner
        completionHandler(victories)
    }
    
    func orderTeamByRank(team: [Transformer]) -> [Transformer] {
        return team.sorted(by: { $0.rank > $1.rank })
    }
        
    private func battle(pTeam: [Transformer], cTeam: [Transformer]) {
        //0. Fight ends if one side is out of Transformers
        guard !pTeam.isEmpty,
            let player: Transformer = pTeam.first,
            !cTeam.isEmpty,
            let computer: Transformer = cTeam.first
            else { return }
        //1. Optimus Prime vs Predaking = game ends right away
        guard !primeVsPredaking(player, computer) else { return }
        
        //2. Optimus Prime OR Predaking vs anyone else is victory
        guard !checkPrimeOrPredaking(player, computer) else {
            fightOver(pTeam, cTeam)
            return
        }
        
        //3. if Str higher than => 4 AND Crg higher than => 3 than that fighter wins
        guard !checkFighterRunsAway(player, computer) else {
            fightOver(pTeam, cTeam)
            return
        }

        //4. if Skl higher than => 3 than that fighter wins
        guard !checkFighterSkill(player, computer) else {
            fightOver(pTeam, cTeam)
            return
        }
        
        //5. Compare Raiting ->  high wins, tie both destroyed
        guard !checkOverallRating(player, computer) else {
            fightOver(pTeam, cTeam)
            return
        }
        
        //6. Go to next fight
        fightOver(pTeam, cTeam)
    }
}

extension BattleManager {
    private func checkOverallRating(_ player: Transformer, _ computer: Transformer) -> Bool {
        if opponentFighterIsSameRating(player, computer) {
            tieFight()
            return true
        }
        if opponentFighterIsLessRating(player, computer) {
            playerWinsFight()
            return true
        }
        if opponentFighterIsLessRating(computer, player) {
            computerWinsFight()
            return true
        }
        return false
    }
    
    private func overallRating(for transformer: Transformer) -> Int {
        return transformer.strength + transformer.intelligence + transformer.speed + transformer.endurance + transformer.firepower
    }
    
    private func opponentFighterIsLessRating(_ transformerOne: Transformer, _ transformerTwo: Transformer) -> Bool {
        if overallRating(for: transformerOne) > overallRating(for: transformerTwo)  {
            return true
        }
        return false
    }
    
    private func opponentFighterIsSameRating(_ transformerOne: Transformer, _ transformerTwo: Transformer) -> Bool {
        if overallRating(for: transformerOne) == overallRating(for: transformerTwo) {
            return true
        }
        return false
    }
}

extension BattleManager {
    private func checkFighterSkill(_ player: Transformer, _ computer: Transformer) -> Bool {
        if opponentFighterIsLessSkillful(player, computer) {
            playerWinsFight()
            return true
        }
        if opponentFighterIsLessSkillful(computer, player) {
            computerWinsFight()
            return true
        }
        return false
    }
    
    private func opponentFighterIsLessSkillful(_ transformerOne: Transformer, _ transformerTwo: Transformer) -> Bool {
        if (transformerOne.skill - transformerTwo.skill) >= 3 {
            return true
        }
        return false
    }
}

extension BattleManager {
    private func checkFighterRunsAway(_ player: Transformer, _ computer: Transformer) -> Bool {
        if opponentFighterRunsAway(player, computer) {
            playerWinsFight()
            return true
        }
        if opponentFighterRunsAway(computer, player) {
            computerWinsFight()
            return true
        }
        return false
    }
    
    private func opponentFighterRunsAway(_ transformerOne: Transformer, _ transformerTwo: Transformer) -> Bool {
        if (transformerOne.strength - transformerTwo.strength) >= 4 &&
            (transformerOne.courage - transformerTwo.courage) >= 3 {
            return true
        }
        return false
    }
}

extension BattleManager {
    private func checkPrimeOrPredaking(_ player: Transformer, _ computer: Transformer) -> Bool {
        if primeOrPredaking(player) {
            playerWinsFight()
            return true
        }
        if primeOrPredaking(computer) {
            computerWinsFight()
            return true
        }
        return false
    }
    
    private func primeOrPredaking(_ transformer: Transformer) -> Bool {
        switch transformer.name {
        case "Optimus Prime":
            return true
        case "Predaking":
            return true
        default:
            return false
        }
    }
}

extension BattleManager {
    private func primeVsPredaking(_ player: Transformer, _ computer: Transformer) -> Bool {
        if player.name == "Optimus Prime" && computer.name == "Predaking" {
            primeVsPredaking = true
            return true
        }
        return false
    }
}

extension BattleManager {
    private func tieFight() {
        victories.player += 1
        victories.computer += 1
    }
    
    private func playerWinsFight() {
        victories.player += 1
    }
    
    private func computerWinsFight() {
        victories.computer += 1
    }
    
    private func fightOver(_ pTeam: [Transformer],_ cTeam: [Transformer]) {
        battle(pTeam: Array(pTeam.dropFirst(1)), cTeam: Array(cTeam.dropFirst(1)))
    }
}
