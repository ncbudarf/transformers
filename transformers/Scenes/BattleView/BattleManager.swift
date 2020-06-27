//
//  BattleManager.swift
//  transformers
//
//  Created by Noah budarf on 2020-06-26.
//  Copyright © 2020 Noah budarf. All rights reserved.
//

import Foundation

enum ArenaEvents: String {
    case listTeams //List the current teams
    case noMoreFighters //One side is out of transformers
    case gameOver //The game is over
    case primeVsPredaking //Prime fights Predaking, ending the game
    case primeIsBattler //Prime fights and wins
    case predakingIsBattler //Predaking fights and wins
    case fightOver //One side wins, start the next fight
    case playerWinsFight //Player wins fight
    case computerWinsFight //Computer wins fight
    case playerRunsAway //Player runs away from fight
    case computerRunsAway //Computer runs away from fight
    case playerIsLessSkillful //Player is not as skilled as opponent
    case computerIsLesSkillful //Computer is not as skilled as opponent
    case playerIsLessOverall //Player is not as overall as opponent
    case computerIsLesOverall //Computer is not as overall as opponent
    case computerAndPlayerEqualOverall //plauer and computer have same overall
    case fightIsTie //The fight is a tie
    case notEnoughFighters //Not enough fighters to play
}

class Victories {
    var player: Int = 0
    var computer: Int = 0
}

class BattleManager {
    var playerTeam: [Transformer] = []
    var computerTeam: [Transformer] = []
    var events: [ArenaEvents] = []
    var victories: Victories = Victories()
    
    typealias CompletionHandler = (_ events:[ArenaEvents]?, _ victories: Victories) -> Void
    
    init(playerFaction: TransformerFaction) {
        guard
            let playerTeam = getTransformers(from: playerFaction),
            !playerTeam.isEmpty,
            let computerTeam = getTransformers(from: computerFaction(from: playerFaction)),
            !computerTeam.isEmpty else {
                events.append(.notEnoughFighters)
                events.append(.gameOver)
                return
            }
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
        events.append(.listTeams)
        
        //2. battle until one team is 'destroyed'
        battle(pTeam: playerTeam, cTeam: computerTeam)
        
        //3. Team that won the most battles is the winner
        completionHandler(events, victories)
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
            else {
                events.append(.noMoreFighters)
                events.append(.gameOver)
                return
        }
        //1. Optimus Prime vs Predaking = game ends right away
        guard !primeVsPredaking(player, computer) else {
            events.append(.gameOver)
            return
        }
        
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
            events.append(.computerAndPlayerEqualOverall)
            tieFight()
            return true
        }
        if opponentFighterIsLessRating(player, computer) {
            events.append(.computerIsLesOverall)
            playerWinsFight()
            return true
        }
        if opponentFighterIsLessRating(computer, player) {
            events.append(.playerIsLessOverall)
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
            events.append(.computerIsLesSkillful)
            playerWinsFight()
            return true
        }
        if opponentFighterIsLessSkillful(computer, player) {
            events.append(.playerIsLessSkillful)
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
            events.append(.computerRunsAway)
            playerWinsFight()
            return true
        }
        if opponentFighterRunsAway(computer, player) {
            events.append(.playerRunsAway)
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
            events.append(.primeIsBattler)
            return true
        case "Predaking":
            events.append(.predakingIsBattler)
            return true
        default:
            return false
        }
    }
}

extension BattleManager {
    private func primeVsPredaking(_ player: Transformer, _ computer: Transformer) -> Bool {
        if player.name == "Optimus Prime" && computer.name == "Predaking" {
            events.append(.primeVsPredaking)
            return true
        }
        return false
    }
}

extension BattleManager {
    private func tieFight() {
        events.append(.fightIsTie)
        victories.player += 1
        victories.computer += 1
    }
    
    private func playerWinsFight() {
        events.append(.playerWinsFight)
        victories.player += 1
    }
    
    private func computerWinsFight() {
        events.append(.computerWinsFight)
        victories.computer += 1
    }
    
    private func fightOver(_ pTeam: [Transformer],_ cTeam: [Transformer]) {
        events.append(.fightOver)
        battle(pTeam: Array(pTeam.dropFirst(1)), cTeam: Array(cTeam.dropFirst(1)))
    }
}
