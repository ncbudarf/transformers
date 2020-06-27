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
    //var battleManager: BattleManager = BattleManager(playerFaction: .autbot)
    var events: [ArenaEvents] = []
    var victories: Victories = Victories()
    
}

extension BattleViewViewModel {
    func factionSelected(_ faction: TransformerFaction) {
        viewState = .battle
        BattleManager(playerFaction: faction).arena(completionHandler: { events, victories in
            guard let events = events else { return }
            self.events = events
            self.victories = victories
        })
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
