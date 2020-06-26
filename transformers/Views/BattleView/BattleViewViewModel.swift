//
//  BattleViewViewModel.swift
//  transformers
//
//  Created by Noah budarf on 2020-06-26.
//  Copyright © 2020 Noah budarf. All rights reserved.
//

import Foundation
import Combine

enum BattleViewState {
    case pickTeam
    case battle
}

class BattleViewViewModel: ObservableObject {
    @Published var viewState: BattleViewState = .pickTeam
}
