//
//  BattleView.swift
//  transformers
//
//  Created by Noah budarf on 2020-06-26.
//  Copyright © 2020 Noah budarf. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

struct BattleView: View {
    @ObservedObject var viewModel: BattleViewViewModel = BattleViewViewModel()
    
    var body: some View {
        VStack {
            if viewModel.viewState == .pickTeam {
                BattleTeamPickerView(viewModel: viewModel)
            } else if viewModel.viewState  == .battle {
                ArenaView(viewModel: viewModel)
            } else {
                Text("pick team")
            }
        }
    }
}
