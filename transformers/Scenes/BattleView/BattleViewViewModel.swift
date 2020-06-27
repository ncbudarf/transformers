//
//  BattleViewViewModel.swift
//  transformers
//
//  Created by Noah budarf on 2020-06-26.
//  Copyright © 2020 Noah budarf. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

enum BattleViewState {
    case pickTeam
    case battle
}

class BattleViewViewModel: ObservableObject {
    @Published var viewState: BattleViewState = .pickTeam
    var battleManager: BattleManager?
    var events: [ArenaEvents] = []
    var victories: Victories = Victories()
    
}

extension BattleViewViewModel {
    func factionSelected(_ faction: TransformerFaction) {
        viewState = .battle
        battleManager = BattleManager(playerFaction: faction)
        battleManager?.arena(completionHandler: { events, victories in
            guard let events = events else { return }
            self.events = events
            self.victories = victories
        })
    }
}

extension BattleViewViewModel {
    func playerTeamNames() -> [String] {
        guard let battleManager = battleManager else { return [] }
        return battleManager.playerTeam.map { $0.name }
    }
    
    func computerTeamNames() -> [String] {
        guard let battleManager = battleManager else { return [] }
        return battleManager.computerTeam.map { $0.name }
    }
    
    func epicBattle() -> Bool {
        return !events.filter{ $0 == ArenaEvents.primeVsPredaking }.isEmpty
    }
    
    func whoWon() -> String {
        if victories.player > victories.computer {
            return "Player Wins!"
        } else if victories.player < victories.computer {
            return "Computer Wins!"
        } else {
            return "Tie Game!"
        }
    }
}

extension BattleViewViewModel {
    func displayVersionOfEvents() -> [String] {
        var stringEventList: [String] = []
        events.forEach { event in
            stringEventList.append(event.rawValue)
        }
        return stringEventList
    }
}

extension BattleViewViewModel {
    func readyToBattleTextColor() -> Color {
        return Color.black
    }
    
    func readyToBattleText() -> String {
        return "Are you Ready to Battle?"
    }
    
    func pickTeamText() -> String {
        return "Pick Team:"
    }
}
