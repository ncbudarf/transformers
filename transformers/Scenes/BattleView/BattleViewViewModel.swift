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
    var victories: Victories = Victories()
    
}

extension BattleViewViewModel {
    func factionSelected(_ faction: TransformerFaction) {
        viewState = .battle
        battleManager = BattleManager(playerFaction: faction)
        battleManager?.arena(completionHandler: { victories in
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
        return battleManager?.primeVsPredaking ?? false
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
    func readyToBattleTextColor() -> Color {
        return Color.black
    }
    
    func readyToBattleText() -> String {
        return "Are you Ready to Battle?"
    }
    
    func pickTeamText() -> String {
        return "Pick Team:"
    }
    
    func noWinnersText() -> String {
        return "Optimus Prime and Predaking fight in an epic battle. There are no winners"
    }
    
    func playerScore() -> String {
        return "Player Score: \(victories.player)"
    }
    
    func computerScore() -> String {
        return "Computer Score: \(victories.computer)"
    }
    
    func playerTeam() -> String {
        return "Player Team:"
    }
    
    func computerTeam() -> String {
        return "Computer Team:"
    }
    
    func exit() -> String {
        return "Exit Arena"
    }
}
